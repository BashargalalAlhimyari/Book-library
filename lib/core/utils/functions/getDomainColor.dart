import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:palette_generator/palette_generator.dart';

Future<Color> getDominantColorFromUrl(String url) async {
  final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
    NetworkImage(url),
  );
  return generator.dominantColor?.color ?? Colors.grey;
}
