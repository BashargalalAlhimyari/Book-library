import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/core/utils/validations/app_validation.dart';
import 'package:clean_architecture/core/widgets/buttons/custom_button.dart';
import 'package:clean_architecture/core/widgets/shared/auth_templete.dart'; // ✅ استخدام القالب
import 'package:clean_architecture/core/widgets/shared/custom_snack_bar.dart';
import 'package:clean_architecture/core/widgets/shared/textFormField.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  // 1️⃣ تعريف المتغيرات
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // 2️⃣ دالة إرسال رابط الاستعادة
  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // إغلاق الكيبورد

      // استدعاء دالة الكيوبت (يجب إضافتها في AuthCubit)
      // context.read<AuthCubit>().resetPassword(email: _emailController.text);

      // ⚠️ محاكاة للعملية حالياً حتى تضيف الدالة في الكيوبت
      CustomSnackBar.show(
        context: context,
        message: "تم إرسال رابط الاستعادة إلى بريدك الإلكتروني",
      );
      // العودة لصفحة الدخول بعد الإرسال
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) GoRouter.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // يمكنك إضافة حالات النجاح والفشل هنا مثل صفحة Login
        if (state is AuthFailure) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        // ✅ 3️⃣ استخدام القالب الموحد
        return AuthTemplate(
          pageTitle: "نسيت كلمة المرور؟",
          pageSubtitle:
              "لا تقلق، أدخل بريدك الإلكتروني وسنرسل لك رابطاً لاستعادة كلمة المرور.",

          body: Form(
            key: _formKey,
            child: Column(
              children: [
                // --- حقل الإيميل ---
                CustomTextField(
                  controller: _emailController,
                  label: "البريد الإلكتروني",
                  hintText: "example@gmail.com",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleResetPassword(),
                  validator: (value) => Validator.email(value),
                ),

                const SizedBox(height: 40),

                // --- زر الإرسال ---
                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      color: AppColors.indigo,
                      text: "إرسال رابط الاستعادة",
                      onPressed: _handleResetPassword,
                      textColor: Colors.white,
                    ),
                  ),

                const SizedBox(height: 25),

                // --- زر العودة للخلف ---
                TextButton.icon(
                  onPressed: () => GoRouter.of(context).pop(), // العودة للدخول
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "العودة لتسجيل الدخول",
                    style: Styles.style14(
                      context,
                    ).copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
