import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skillsift_flutter_app/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final bool? readOnly;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final bool? obscureText;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onSuffixTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmit;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  // bool readOnly;

  const CustomTextFormField({
    Key? key,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
    this.onSuffixTap,
    this.keyboardType,
    this.validator,
    this.onSave,
    this.inputFormatters,
    this.textInputAction,
    this.onEditingComplete,
    this.controller,
    this.onFieldSubmit,
    this.readOnly,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.fillColor,
    this.autofocus,
    this.textCapitalization,

    // this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Get.find<ThemeController>().isDarkMode;
    return TextFormField(
      // cursorColor: isDarkMode
      //     ? DarkColorsManager.whiteColor
      //     : ColorsManager.primaryColor,
      cursorColor: AppColors.primaryLightColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(
          // color: isDarkMode
          //     ? DarkColorsManager.whiteColor
          //     : ColorsManager.primaryColor,
          color: AppColors.black,
          fontSize: Sizes.SIZE_16,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
            color: AppColors.black,
            fontSize: Sizes.SIZE_16,
            fontWeight: FontWeight.normal),
        prefixIcon: prefixIconData != null
            ? Icon(
                prefixIconData,
                size: 20,
                color: AppColors.secondaryColorDark,
              )
            : null,
        suffixIcon: suffixIconData != null
            ? InkWell(
                onTap: onSuffixTap,
                child: Icon(
                  suffixIconData,
                  size: 20,
                  color: AppColors.secondaryColorDark,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryLightColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.secondaryColorDark,
          fontSize: Sizes.SIZE_20,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.primaryLightColor, width: 1),
          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
        ),

        // fillColor: fillColor ?? kCreamColor,
        // filled: true,
        alignLabelWithHint: true,

        focusColor: AppColors.secondaryColorDark,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: Sizes.SIZE_12,
        ),

        // contentPadding: maxLines == null
        //     ? const EdgeInsets.all(8)
        //     : const EdgeInsets.symmetric(vertical: 15),
      ),

      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      autofocus: autofocus ?? true,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
      controller: controller,
      onFieldSubmitted: onFieldSubmit,
      // readOnly: readOnly,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      scrollPadding: const EdgeInsets.all(8),
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      toolbarOptions: const ToolbarOptions(
        cut: true,
        copy: true,
        selectAll: true,
        paste: true,
      ),
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: true,
      onSaved: onSave,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      style: const TextStyle(
        // fontFamily: 'Ubuntu',
        color: AppColors.black,
        fontSize: Sizes.SIZE_16,
      ),
    );
  }
}
