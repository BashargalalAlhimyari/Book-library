
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/widgets/buttons/custom_button.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:flutter/material.dart';

class BuildBottomAction extends StatelessWidget {
  const BuildBottomAction({
    super.key,
    required this.book,
  });

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            offset: const Offset(0, -5),
            blurRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // زر المعاينة
            Expanded(
              flex: 1,
              child: CustomButton(
                text: "Free Preview",
                textColor: AppColors.textPrimaryLight,
                color: AppColors.bgLight,
                onPressed: () {},
                // يمكن تعديل الستايل ليكون Border فقط إذا أردت
              ),
            ),
            const SizedBox(width: 15),
            // زر الشراء
            Expanded(
              flex: 2,
              child: CustomButton(
                text:
                    book.price == 0 || book.price == null
                        ? "Download Now"
                        : "Buy for ${book.price}\$",
                textColor: Colors.white,
                color: AppColors.primary,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
