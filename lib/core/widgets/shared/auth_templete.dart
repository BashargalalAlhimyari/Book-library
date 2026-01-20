import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/core/widgets/shared/responsive_layout.dart';
import 'package:flutter/material.dart';

class AuthTemplate extends StatelessWidget {
  final Widget body; // هذا هو الفورم المتغير (Login, SignUp, etc)
  final String? pageTitle; // عنوان الصفحة (اختياري)
  final String? pageSubtitle; // وصف الصفحة (اختياري)

  const AuthTemplate({
    super.key,
    required this.body,
    this.pageTitle,
    this.pageSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) => MopileAuthLayout(body: body),
        desktopLayout:
            (context) => DesctopAuthLayout(
              pageTitle: pageTitle,
              pageSubtitle: pageSubtitle,
              body: body,
            ),
        tabletLayout:
            (context) => DesctopAuthLayout(
              pageTitle: pageTitle,
              pageSubtitle: pageSubtitle,
              body: body,
            ),
      ),
    );
  }
}

class MopileAuthLayout extends StatelessWidget {
  const MopileAuthLayout({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          BuildMobileHeader(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: body, // ✅ هنا نضع الفورم
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class BuildMobileHeader extends StatelessWidget {
  const BuildMobileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.35,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const _VisualBrandingSection(),
    );
  }
}

class DesctopAuthLayout extends StatelessWidget {
  const DesctopAuthLayout({
    super.key,
    required this.pageTitle,
    required this.pageSubtitle,
    required this.body,
  });

  final String? pageTitle;
  final String? pageSubtitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (pageTitle != null) ...[
                        Text(pageTitle!, style: Styles.style30(context)),
                        const SizedBox(height: 10),
                        Text(
                          pageSubtitle ?? "",
                          style: Styles.style14(
                            context,
                          ).copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                      ],
                      body, // ✅ هنا نضع الفورم
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity, // لضمان أن الخلفية تملأ الشاشة دائماً
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            // ✅ الحل: وضعنا المحتوى داخل Center و SingleChildScrollView
            child: const Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20), // مسافة أمان
                child: _VisualBrandingSection(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// قسم الشعار الثابت (يمكنك نقله لملف منفصل أيضاً)
class _VisualBrandingSection extends StatelessWidget {
  const _VisualBrandingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Kitabi",
          style: Styles.style30(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Your gateway to knowledge",
          style: Styles.style16(context).copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
