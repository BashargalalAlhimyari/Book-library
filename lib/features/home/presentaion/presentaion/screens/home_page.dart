import 'package:clean_architecture/core/widgets/shared/responsive_layout.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/layouts/desktop_layout.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/layouts/mobile_layout.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/layouts/tablet_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      desktopLayout: (context) => const DesktopLayout(),
      mobileLayout: (context) => const MobileLayout(),
      tabletLayout: (context) => const TabletLayout(),
    );
  }
}
