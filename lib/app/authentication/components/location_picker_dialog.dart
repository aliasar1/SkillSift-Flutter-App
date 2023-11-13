import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocationPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        child: Column(
          children: [
            AppBar(
              title: const Text('Current Location'),
            ),
            Expanded(
              child: MyLocationPickerMap(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  // Access the state using the global key and get the selected location
                  LatLng? selectedLocation = MyLocationPickerMap
                      .mapKey.currentState
                      ?.getSelectedLocation();

                  Navigator.of(context)
                      .pop(selectedLocation); // Close the dialog
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
  static final GlobalKey<_MyLocationPickerMapState> mapKey =
      GlobalKey<_MyLocationPickerMapState>();
  @override
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
          : Set(),
    );
  }

  LatLng? getSelectedLocation() {
    return _selectedLocation;
  }
}
