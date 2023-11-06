import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

class CustomSearchWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmit;

  const CustomSearchWidget(
      {Key? key, this.controller, this.validator, this.onFieldSubmit})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: LightTheme.whiteShade1,
      ),
      child: TextFormField(
        cursorColor: LightTheme.black,
        controller: widget.controller,
        onFieldSubmitted: widget.onFieldSubmit,
        onChanged: widget.onFieldSubmit,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: LightTheme.black),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: LightTheme.primaryColor,
          ),
          hintText: 'Search for...',
          hintStyle:
              TextStyle(color: LightTheme.black, fontWeight: FontWeight.normal),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
