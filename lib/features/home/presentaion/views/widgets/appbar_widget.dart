
import 'package:clean_architecture/core/utils/manager/locale_cubit.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 40 , bottom: 10),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.language), onPressed: () {
             if (Localizations.localeOf(context).languageCode == 'ar') {
          context.read<LocaleCubit>().changeLanguage('en');
        } else {
          context.read<LocaleCubit>().changeLanguage('ar');
        }
          },),
          Spacer(),
          IconButton(onPressed: () {
           
          }, icon: Icon(Icons.search, size: 30)),
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              GoRouter.of(context).go('/');
            },
            icon: const Icon(Icons.logout, size: 30),
          ),
        ],
      ),
    );
  }
}
