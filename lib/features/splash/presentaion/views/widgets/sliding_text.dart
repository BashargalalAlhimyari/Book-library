
import 'package:flutter/material.dart';

class AnimatedSlider extends StatelessWidget {
  const AnimatedSlider({
    super.key,
    required this.slideAnimation,
  });

  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position:slideAnimation ,
       child: AnimatedBuilder(
        animation: slideAnimation,
        builder :(context, _)=>
     const   Text("hello to our library", textAlign: TextAlign.center)));
  }
}
