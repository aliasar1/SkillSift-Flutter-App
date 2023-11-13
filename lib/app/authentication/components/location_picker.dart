import 'package:flutter/material.dart';

import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/autocomplete_prediction.dart';
import '../../../core/models/place_autocomplete_response.dart';
import '../../../core/services/place_api.dart';
import '../../../core/widgets/location_tile.dart';
import 'location_picker_dialog.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: placeController,
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: "Search your location",
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.abc),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: LightTheme.black,
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
                  print(result);
                  placeController.value = result;
                } else {
                  print('Dialog closed without a result');
                }
              },
              icon: const Icon(Icons.pin_drop),
              label: const Text("Use my Current Location"),
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
            color: LightTheme.black,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) => LocationListTile(
                press: () {
                  setState(() {
                    placeController.text = places[index].description!;
                    places.clear();
                  });
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
