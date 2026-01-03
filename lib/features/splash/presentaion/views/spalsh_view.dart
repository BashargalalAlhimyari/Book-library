import 'package:clean_architecture/features/splash/presentaion/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100b20),
      body: SplashViewBody()
    );
  }
}
