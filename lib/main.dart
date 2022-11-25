import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/controllers/courses_controller.dart';
import 'package:course_guide/controllers/nav_control.dart';
import 'package:course_guide/controllers/notifications.dart';
import 'package:course_guide/firebase_options.dart';
import 'package:course_guide/router.dart';
import 'package:course_guide/views/home/profile/widget/edit_profile_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  // ensure binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // init firebase from options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final auth;

  @override
  void initState() {
    super.initState();
    auth = Auth();
  }

  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ProfileForm(auth)),
              ChangeNotifierProvider<Auth>.value(
                value: auth,
              ),
              ChangeNotifierProvider(
                create: (_) => NotificationsController(auth),
              ),
              ChangeNotifierProvider(create: (_)=> CourseController()),
              ChangeNotifierProvider(create: (_)=> NavController()),
              ChangeNotifierProvider(create: (_)=> ProfileForm(auth)),


            ],
            child: MaterialApp.router(
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
            ),
          );
        });
  }
}
