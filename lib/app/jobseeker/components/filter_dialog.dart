import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../../core/widgets/custom_dropdown.dart';

// ignore: must_be_immutable
class FilterDialog extends StatefulWidget {
  FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final modeList = [
    'Onsite',
    'Remote',
    'Hybrid',
  ];

  var selectedMode = 'Onsite';

  final typeList = [
    'Full Time',
    'Part Time',
    'Contract Based',
  ];

  var selectedType = 'Full Time';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Jobs'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDropdown(
            icon: Icons.mode_comment,
            selectedValue: selectedMode,
            items: modeList,
            title: 'Job Mode',
            onChanged: (value) {
              setState(() {
                selectedMode = value!;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropdown(
            icon: Icons.badge,
            selectedValue: selectedType,
            items: typeList,
            title: 'Job Tyoe',
            onChanged: (value) {
              setState(() {
                selectedType = value!;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(LightTheme.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Sort by latest jobs posted",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Apply filters and update the job list
            // Call the appropriate function in your controller
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
