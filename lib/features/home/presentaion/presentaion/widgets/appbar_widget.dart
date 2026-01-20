


import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const  Text("أهلاً، أحمد ", style: Styles.textStyle30),
              Text(
                "ماذا ستقرأ اليوم؟",
                style: Styles.textStyle14.copyWith(
                  color: AppColors.grey400,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.indigo,
            ),
            style: IconButton.styleFrom(
              backgroundColor:
                  isDark ? AppColors.surfaceDark : Colors.white,
              shadowColor: Colors.black12,
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:clean_architecture/core/l10n/locale_cubit.dart';
// import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class AppBarWidget extends StatelessWidget {
//   const AppBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only( top: 40 , bottom: 10),
//       child: Row(
//         children: [
//           IconButton(icon: Icon(Icons.language), onPressed: () {
//              if (Localizations.localeOf(context).languageCode == 'ar') {
//           context.read<LocaleCubit>().changeLanguage('en');
//         } else {
//           context.read<LocaleCubit>().changeLanguage('ar');
//         }
//           },),
//           Spacer(),
//           IconButton(onPressed: () {
           
//           }, icon: Icon(Icons.search, size: 30)),
//           IconButton(
//             onPressed: () {
//               context.read<AuthCubit>().logout();
//               GoRouter.of(context).go('/');
//             },
//             icon: const Icon(Icons.logout, size: 30),
//           ),
//         ],
//       ),
//     );
//   }
// }
