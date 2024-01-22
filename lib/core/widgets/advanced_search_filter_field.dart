import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

class CustomSearchFilterWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmit;
  final String? label;
  final VoidCallback onFilterTap;

  const CustomSearchFilterWidget({
    Key? key,
    this.controller,
    this.validator,
    this.onFieldSubmit,
    this.label,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSearchFilterWidgetState createState() =>
      _CustomSearchFilterWidgetState();
}

class _CustomSearchFilterWidgetState extends State<CustomSearchFilterWidget> {
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
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: LightTheme.primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: widget.onFilterTap,
            child: const Icon(
              Icons.filter_list,
              color: LightTheme.primaryColor,
            ),
          ),
          hintText: widget.label ?? 'Search for...',
          hintStyle: const TextStyle(
              color: LightTheme.black, fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
