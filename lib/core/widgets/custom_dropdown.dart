import 'package:flutter/material.dart';

import '../constants/theme/light_theme.dart';
import '../exports/constants_exports.dart';
import 'custom_text.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final String selectedValue;
  final List<String> items;
  final void Function(String?) onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          title: title,
          fontContainerWidth: double.infinity,
          textAlign: TextAlign.start,
          textStyle: const TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: LightTheme.primaryColorLightShade,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
          ),
          child: DropdownButtonFormField(
            elevation: 0,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: LightTheme.primaryColor),
            ),
            value: selectedValue,
            isExpanded: true,
            items: items.map(buildDropdownItem).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

DropdownMenuItem<String> buildDropdownItem(String item) => DropdownMenuItem(
      value: item,
      child: Txt(
        title: item,
        fontContainerWidth: double.infinity,
        textAlign: TextAlign.start,
        textStyle: const TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.black,
          fontSize: Sizes.TEXT_SIZE_14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
