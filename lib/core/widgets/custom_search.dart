import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/dark_theme.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

class CustomSearchWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmit;
  final String? label;
  final bool? readOnly;

  const CustomSearchWidget(
      {Key? key,
      this.controller,
      this.validator,
      this.onFieldSubmit,
      this.label,
      this.readOnly})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchWidgetState createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? DarkTheme.containerColor : LightTheme.whiteShade1,
      ),
      child: TextFormField(
        cursorColor: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
        controller: widget.controller,
        onFieldSubmitted: widget.onFieldSubmit,
        onChanged: widget.onFieldSubmit,
        readOnly: widget.readOnly ?? false,
        validator: widget.validator,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: LightTheme.primaryColor,
          ),
          hintText: widget.label ?? 'Search for...',
          hintStyle: TextStyle(
              color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
              fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: LightTheme.primaryColor,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: LightTheme.primaryColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: LightTheme.primaryColor,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
