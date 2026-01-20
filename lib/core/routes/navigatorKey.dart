import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/*
نحن صنعنا "باباً خلفياً" (Global Key) 
يسمح لك بالوصول إلى الشاشة الحالية والتحكم بها من داخل الكود البرمجي (Dio) 
دون الحاجة لتمرير context من الواجهات.
 */