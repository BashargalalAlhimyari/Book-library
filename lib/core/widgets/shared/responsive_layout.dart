import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
     this.tabletLayout,
    required this.desktopLayout,
  });

  final WidgetBuilder mobileLayout;
  final WidgetBuilder? tabletLayout;
  final WidgetBuilder desktopLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth < AppConstants.mobileBreakpoint) {
          return mobileLayout(context);
        } else if (constrains.maxWidth < AppConstants.tabletBreakpoint) {
          return tabletLayout!(context);
        } else {
          return desktopLayout(context);
        }
      },
    );
  }
}
