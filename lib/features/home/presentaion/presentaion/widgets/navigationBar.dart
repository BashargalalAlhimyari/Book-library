import 'dart:ui';
import 'package:clean_architecture/core/theme/styles.dart';

import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/navigate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color:
              Theme.of(context).brightness == Brightness.light
                  ? Colors.white.withOpacity(0.8)
                  : AppColors.bgDark.withOpacity(0.8),
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.05)),
          ),
        ),
        child: BlocBuilder<NavigateCubit, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BuildBottomNavItem(
                  icon: Icons.grid_view_rounded,
                  label: "الرئيسية",
                  index: 0,
                ),
                BuildBottomNavItem(
                  icon: Icons.search_rounded,
                  label: "استكشف",
                  index: 1,
                ),
                BuildBottomNavItem(
                  icon: Icons.book_rounded,
                  label: "مكتبتي",
                  index: 2,
                ),
                BuildBottomNavItem(
                  icon: Icons.person_outline_rounded,
                  label: "بروفايل",
                  index: 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BuildBottomNavItem extends StatelessWidget {
  IconData icon;
  String label;
  int index;
  BuildBottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    bool isActive = context.read<NavigateCubit>().state == index;
    return GestureDetector(
      onTap: () => context.read<NavigateCubit>().moveToIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.indigo : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.indigo : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
