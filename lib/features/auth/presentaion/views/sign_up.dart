import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/routes/appRouters.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/utils/validations/app_validation.dart';
import 'package:clean_architecture/core/widgets/buttons/custom_button.dart';
import 'package:clean_architecture/core/widgets/shared/auth_templete.dart';
import 'package:clean_architecture/core/widgets/shared/custom_snack_bar.dart';
import 'package:clean_architecture/core/widgets/shared/textFormField.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // 1️⃣ تعريف المفاتيح والكونترولرز
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  // متغيرات لحالة إظهار كلمة المرور
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 2️⃣ دالة التسجيل
  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // استدعاء الكيوبت (تأكد من وجود دالة signUp في الكيوبت لديك)
      context.read<AuthCubit>().register(
        username: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      // محاكاة للنجاح مؤقتاً
      CustomSnackBar.show(
        context: context,
        message: "Account Created Successfully",
      );
      GoRouter.of(context).go(Routes.homePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomSnackBar.show(
            context: context,
            message: "Account created successfully!",
          );
          GoRouter.of(context).go(Routes.homePage);
        } else if (state is AuthFailure) {
          CustomSnackBar.show(
            context: context,
            message: state.message,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AuthTemplate(
          pageTitle: "Create Account",
          pageSubtitle: "Join us and start your reading journey today",

          body: Form(
            key: _formKey,
            child: Column(
              children: [
                // --- الاسم الكامل ---
                CustomTextField(
                  controller: _nameController,
                  label: "الاسم الكامل",
                  // hintText: "John Doe",
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.length < 3) {
                      return "Name must be at least 3 characters";
                    }
                    return null;
                  },
                 
                ),

                const SizedBox(height: 20),

                // --- البريد الإلكتروني ---
                CustomTextField(
                  controller: _emailController,
                  label: "البريد الإلكتروني",
                  hintText: "example@gmail.com",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.email(value),
                ),

                const SizedBox(height: 20),

                // --- كلمة المرور ---
                CustomTextField(
                  controller: _passwordController,
                  label: "كلمة المرور",
                  hintText: "********",
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  obscureText: !_isPasswordVisible, // استخدام المتغير الصحيح
                  prefixIcon: Icons.lock_outline,
                 onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.password(value),
                ),

                const SizedBox(height: 20),

                // --- تأكيد كلمة المرور ---
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: "تأكيد كلمة المرور",
                  hintText: "********",
                  isPassword: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  obscureText: !_isConfirmPasswordVisible,
                   prefixIcon: Icons.check_circle_outline_outlined, // أيقونة مختلفة
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleSignUp(),
                  // ⚠️ تحقق خاص لتطابق الكلمتين
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please confirm password";
                    if (value != _passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // --- زر التسجيل ---
                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      color: AppColors.indigo,
                      text: "إنشاء حساب",
                      onPressed: _handleSignUp,
                      textColor: Colors.white,
                    ),
                  ),

                const SizedBox(height: 20),

                // --- رابط العودة لتسجيل الدخول ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "لديك حساب بالفعل؟",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop(); // العودة للخلف (Login)
                      },
                      child: const Text(
                        "سجل دخول",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
