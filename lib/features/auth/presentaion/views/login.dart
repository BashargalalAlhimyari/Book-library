import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/core/utils/cache/shared_pref.dart';
import 'package:clean_architecture/core/utils/validations/app_validation.dart';
import 'package:clean_architecture/core/widgets/buttons/custom_button.dart';
import 'package:clean_architecture/core/widgets/shared/auth_templete.dart';
import 'package:clean_architecture/core/widgets/shared/custom_snack_bar.dart';
import 'package:clean_architecture/core/widgets/shared/textFormField.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // 1️⃣ تعريف المتغيرات
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 2️⃣ دالة تسجيل الدخول
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // إغلاق الكيبورد لتجربة مستخدم أفضل
      FocusScope.of(context).unfocus();

      context.read<AuthCubit>().login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomSnackBar.show(
            context: context,
            message: "Welcome back! Login Successful",
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
          pageTitle: "مرحباً بعودتك",
          pageSubtitle: "يرجى إدخال بياناتك للمتابعة",

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
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator.email(value),
                ),

                const SizedBox(height: 20),

                // --- حقل كلمة المرور ---
                CustomTextField(
                  controller: _passwordController,
                  label: "كلمة المرور",
                  hintText: "********",
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  obscureText: _isPasswordVisible, // التحكم بالإخفاء
                  prefixIcon: Icons.lock_outline,
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted:
                      (_) => _handleLogin(), // الضغط على Enter للدخول مباشرة
                  validator: (value) => Validator.password(value),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft, // أو Right حسب لغة التطبيق
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).go(Routes.registerPage);
                    },
                    child: Text(
                      "هل نسيت كلمة المرور؟",
                      style: Styles.style14(context).copyWith(
                        color: AppColors.indigo,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      color: AppColors.indigo,
                      text: "تسجيل الدخول",
                      onPressed: _handleLogin,
                      textColor: Colors.white,
                    ),
                  ),

                const SizedBox(height: 25),

                // --- الانتقال لصفحة التسجيل ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ليس لديك حساب؟",
                      style: Styles.style14(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(Routes.signUp);
                      },
                      child: Text(
                        "سجل الآن",
                        style: Styles.style14(context).copyWith(
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
