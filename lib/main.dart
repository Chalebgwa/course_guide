import 'package:course_guide/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Course Guide',
            theme: ThemeData(
              colorScheme: ColorScheme.light(
                primary: HexColor('#FFC107'),
                secondary: HexColor('#FDE84C'),
              ),
            ),
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
          );
        });
  }
}
