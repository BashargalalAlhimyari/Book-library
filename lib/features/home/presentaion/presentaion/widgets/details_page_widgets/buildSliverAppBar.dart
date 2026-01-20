
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildSliverAppBar extends StatelessWidget {
  const BuildSliverAppBar({
    super.key,
    required this.book,
  });

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 450,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.bgDark,
      leading:
          MediaQuery.of(context).size.width > 700
              ? null
              : IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, color: Colors.white),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // الطبقة 1: الصورة الخلفية المشوشة (Blur)
            if (book.coverUrl != null || (book.images?.isNotEmpty ?? false))
              CachedNetworkImage(
                imageUrl: book.coverUrl ?? book.images!.first,
                fit: BoxFit.cover,
              ),
            // الطبقة 2: تأثير الضباب
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
            // الطبقة 3: صورة الكتاب الواضحة في المنتصف
            Center(
              child: Hero(
                tag: book.bookId, // أنيميشن جميل عند الانتقال
                child: Container(
                  width: 180,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          book.coverUrl ??
                          (book.images?.isNotEmpty ?? false
                              ? book.images!.first
                              : ""),
                      fit: BoxFit.fill,
                      errorWidget:
                          (context, url, error) =>
                              const Icon(Icons.book, size: 50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
