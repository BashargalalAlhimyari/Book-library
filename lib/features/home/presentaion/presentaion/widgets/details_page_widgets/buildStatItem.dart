
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class BuildStatItem extends StatelessWidget {
  const BuildStatItem({
    super.key,
    required this.context,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final BuildContext context;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 4),
            Text(
              value,
              style: Styles.style16(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Styles.style12(context).copyWith(color: AppColors.grey400),
        ),
      ],
    );
  }
}