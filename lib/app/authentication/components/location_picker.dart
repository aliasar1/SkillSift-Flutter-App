import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../core/constants/theme/light_theme.dart';
import '../../../core/exports/constants_exports.dart';
import '../../../core/models/autocomplete_prediction.dart';
import '../../../core/models/location_long_lat.dart';
import '../../../core/models/place_autocomplete_response.dart';
import '../../../core/services/place_api.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/location_tile.dart';
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
        {"input": query, "key": 'AIzaSyAC41qD4CKnJGwlWAXs46TPoBvxwLwc5e4'});
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: LightTheme.primaryColor,
          iconTheme: const IconThemeData(color: LightTheme.white),
          elevation: 0,
          title: const Txt(
            title: "Pick Location",
            textAlign: TextAlign.start,
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
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
                onSuffixTap: () {
                  if (placeController.text.isNotEmpty) {
                    widget.authController.toggleIsLocPicked();
                    Get.back();
                  } else {
                    Get.snackbar(
                      'Location Error!',
                      'Please search or pick location.',
                    );
                  }
                },
                onChanged: (value) {
                  placeAutocomplete(value!);
                },
              ),
            ),
            const Divider(
              height: 4,
              thickness: 4,
              color: LightTheme.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                onPressed: () async {
                  var result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MyLocationPickerDialog();
                    },
                  );

                  if (result != null) {
                    placeController.value = result;
                    print(result);
                  } else {
                    print('Dialog closed without a result');
                  }
                },
                icon: const Icon(
                  Icons.public,
                  color: LightTheme.primaryColor,
                ),
                label: const Txt(
                  title: "Use my current location",
                  fontContainerWidth: 200,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.black,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightTheme.white,
                  foregroundColor: LightTheme.black,
                  elevation: 0,
                  fixedSize: const Size(double.infinity, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 4,
              thickness: 4,
              color: LightTheme.grey,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) => LocationListTile(
                  press: () {
                    setState(() {
                      placeController.text = places[index].description!;
                      widget.authController
                          .getPlaceDetails(places[index].placeId!);
                      places.clear();
                    });
                  },
                  location: places[index].description!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
