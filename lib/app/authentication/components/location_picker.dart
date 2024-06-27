import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/autocomplete_prediction.dart';
import '../../../core/models/place_autocomplete_response.dart';
import '../../../core/services/place_api.dart';
import '../controllers/auth_controller.dart';
import 'location_picker_dialog.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key, required this.authController})
      : super(key: key);
  final AuthController authController;

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<AutocompletePrediction> places = [];
  final placeController = TextEditingController();

  void placeAutocomplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, "key": 'ADD PLACES API KEY HERE'});
    String? response = await PlaceApi.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          places = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        iconTheme: IconThemeData(
            color: isDarkMode
                ? DarkTheme.whiteGreyColor
                : LightTheme.secondaryColor),
        elevation: 0,
        title: Txt(
          title: "Pick Location",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextFormField(
              controller: placeController,
              labelText: "Search your location",
              autofocus: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              prefixIconData: Icons.pin_drop,
              suffixIconData: Icons.check,
              onChanged: (value) {
                placeAutocomplete(value!);
              },
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: isDarkMode ? DarkTheme.lightGreyColor : LightTheme.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton.icon(
              onPressed: () async {
                var result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const MyLocationPickerDialog();
                  },
                );
                if (result != null) {
                  if (widget.authController.location.isEmpty) {
                    widget.authController.toggleIsLocPicked();
                  }

                  double latitude = result.latitude;
                  double longitude = result.longitude;

                  widget.authController.location.value = <double>[
                    latitude,
                    longitude
                  ];

                  Get.back();
                }
              },
              icon: const Icon(
                Icons.public,
                color: LightTheme.primaryColor,
              ),
              label: Txt(
                title: "Use my current location",
                fontContainerWidth: 200,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? DarkTheme.cardBackgroundColor
                    : LightTheme.whiteShade2,
                foregroundColor:
                    isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Divider(
            height: 4,
            thickness: 4,
            color: isDarkMode ? DarkTheme.lightGreyColor : LightTheme.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) => LocationListTile(
                press: () {
                  if (placeController.text.isNotEmpty) {
                    if (widget.authController.location.isEmpty) {
                      widget.authController.toggleIsLocPicked();
                    }

                    setState(() {
                      placeController.text = places[index].description!;
                      widget.authController
                          .getPlaceDetails(places[index].placeId!);
                      places.clear();
                    });

                    Get.back();
                  } else {
                    Get.snackbar(
                      'Location Error!',
                      'Please search or pick a location.',
                    );
                  }
                },
                location: places[index].description!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
