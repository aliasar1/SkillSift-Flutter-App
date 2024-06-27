import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_text.dart';

class MyLocationPickerDialog extends StatelessWidget {
  const MyLocationPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: SizedBox(
        height: Get.height * 0.6,
        width: double.infinity,
        child: Column(
          children: [
            AppBar(
              backgroundColor: LightTheme.primaryColor,
              iconTheme: const IconThemeData(color: LightTheme.white),
              title: const Txt(
                title: "Current Location",
                fontContainerWidth: double.infinity,
                textAlign: TextAlign.start,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.white,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(
              child: MyLocationPickerMap(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(LightTheme.primaryColor),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );
                  Get.back(result: position);
                },
                child: const Txt(
                  title: "Confirm",
                  textAlign: TextAlign.center,
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.white,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyLocationPickerMap extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static final GlobalKey<_MyLocationPickerMapState> mapKey =
      GlobalKey<_MyLocationPickerMapState>();

  const MyLocationPickerMap({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyLocationPickerMapState createState() => _MyLocationPickerMapState();
}

class _MyLocationPickerMapState extends State<MyLocationPickerMap> {
  late GoogleMapController _controller;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle the scenario when user permanently denies location permission
      // You can show a dialog or navigate the user to app settings
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });

    _controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        15.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      initialCameraPosition: _selectedLocation != null
          ? CameraPosition(
              target: _selectedLocation!, // Initial map center
              zoom: 15.0, // Initial zoom level
            )
          : const CameraPosition(
              target: LatLng(0.0, 0.0), // Initial map center
              zoom: 15.0, // Initial zoom level
            ),
      onTap: (LatLng location) {
        setState(() {
          _selectedLocation = location;
        });
      },
      markers: _selectedLocation != null
          ? {
              Marker(
                markerId: const MarkerId('SelectedLocation'),
                position: _selectedLocation!,
              ),
            }
          // ignore: prefer_collection_literals
          : Set(),
    );
  }

  LatLng? getSelectedLocation() {
    return _selectedLocation;
  }
}
