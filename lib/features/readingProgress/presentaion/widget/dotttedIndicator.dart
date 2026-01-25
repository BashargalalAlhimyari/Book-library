import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/card_doted_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DottedIndicator extends StatelessWidget {
  const DottedIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDotedCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: state == index ? 24 : 8,
              decoration: BoxDecoration(
                color: AppColors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        );
      },
    );
  }
}