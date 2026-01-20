import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  });

  // المتغيرات الأساسية
  final TextEditingController controller;
  final String? hintText;
  final String? label; // اختياري: إذا أردت عنواناً فوق الحقل

  final bool? isPassword;
  final bool? isPasswordVisible;

  // الأيقونات
  final IconData? prefixIcon; // أيقونة في البداية
  final IconData? suffixIcon; // أيقونة في البداية

  // التحكم والسلوك
  final bool obscureText; // لإخفاء النص (للباسورد)
  final String? Function(String?)? validator; // للتحقق من الأخطاء
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputType keyboardType; // نوع الكيبورد (أرقام، ايميل...)
  final TextInputAction textInputAction; // زر الكيبورد (التالي، تم...)

  // التنسيق والحالات الخاصة
  final int maxLines; // لجعله مربع نص كبير (الوصف)
  final bool readOnly; // للقراءة فقط (مثل حقل التاريخ)
  final VoidCallback? onTap; // عند الضغط عليه
  final Color? fillColor; // لتغيير لون الخلفية حسب الحاجة

  @override
  Widget build(BuildContext context) {
    // تحديد الألوان بناءً على الثيم (Dark/Light)
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final outlineColor =
        isDark ? AppColors.grey200.withOpacity(0.2) : AppColors.grey200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. عنوان الحقل (اختياري)
        if (label != null) ...[
          Text(
            label!,
            style: Styles.style14(context).copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white70 : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // 2. الحقل نفسه
        TextFormField(
          controller: controller,

          // الخصائص السلوكية
          obscureText: isPassword! && !isPasswordVisible!,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          style: Styles.style16(context).copyWith(
            color: isDark ? Colors.white : Colors.black,
          ), // لون النص المدخل
          // خصائص التزيين (Decoration)
          decoration: InputDecoration(
            suffixIcon:
                isPassword!
                    ? IconButton(
                      icon: Icon(
                        isPasswordVisible!
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: onTap,
                    )
                    : null,

            hintText: hintText,
            hintStyle: Styles.style14(
              context,
            ).copyWith(color: AppColors.grey400),

            // لون الخلفية
            filled: true,
            fillColor:
                fillColor ??
                (isDark ? AppColors.surfaceDark : AppColors.bgLight),

            // الأيقونات
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: AppColors.grey400, size: 22)
                    : null,

            // المسافات الداخلية
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),

            // الحدود (Borders) - أهم جزء للتصميم الاحترافي
            border: _buildBorder(outlineColor), // الحدود العادية
            enabledBorder: _buildBorder(outlineColor), // الحدود وهو غير نشط
            focusedBorder: _buildBorder(
              AppColors.indigo,
            ), // الحدود عند الكتابة (لون مميز)
            errorBorder: _buildBorder(AppColors.red), // الحدود عند الخطأ
            focusedErrorBorder: _buildBorder(
              AppColors.red,
            ), // الحدود عند الخطأ والتركيز
          ),
        ),
      ],
    );
  }

  // دالة مساعدة لتوحيد شكل الحدود
  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12), // انحناء الحواف
      borderSide: BorderSide(
        color: color,
        width: 1.5, // سماكة الخط
      ),
    );
  }
}
