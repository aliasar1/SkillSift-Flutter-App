import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/models/autocomplete_prediction.dart';
import '../../../core/widgets/location_tile.dart';

// ignore: must_be_immutable
class LocationPickerDialog extends StatelessWidget {
  LocationPickerDialog(
      {super.key,
      required this.placeController,
      required this.placeAutocomplete});

  final TextEditingController placeController;
  final Function(String) placeAutocomplete;
  List<AutocompletePrediction> places = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Location Picker'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        child: Icon(Icons.pin_drop),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 4,
                thickness: 4,
                color: Colors.black, // Customize the color if needed
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop(
                        placeController.text); // Return the selected location
                  },
                  icon: Icon(Icons.pin_drop),
                  label: const Text("Use my Current Location"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightTheme.primaryColor,
                    foregroundColor: LightTheme.white,
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
                color: Colors.black, // Customize the color if needed
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) => LocationListTile(
                    press: () {
                      Navigator.of(context).pop(places[index]
                          .description); // Return the selected location
                    },
                    location: places[index].description!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
