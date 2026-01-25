import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.fillColor, 
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.suffixIcon,
    this.suffixIconWidget,
    this.onSuffixPressed,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final bool? isPassword;
  final bool? isPasswordVisible;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget; // في حال أردت وضع ويدجت مخصصة
  final VoidCallback? onSuffixPressed;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. العنوان (Label)
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 8),
        ],

        // 2. الحقل
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          
          style: Theme.of(context).textTheme.bodyLarge,
          
          cursorColor: Theme.of(context).primaryColor,

          decoration: InputDecoration(
          
            filled: true, 
            fillColor: fillColor, 

            // الأيقونات
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 22) // اللون يأتي من iconTheme
                : null,

            suffixIcon: isPassword == true
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: onSuffixPressed,
                  )
                : suffixIcon != null 
                    ? Icon(suffixIcon) 
                    : suffixIconWidget,

          ),
        ),
      ],
    );
  }
}