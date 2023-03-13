import 'package:course_guide/controllers/auth.dart';
import 'package:course_guide/controllers/courses_controller.dart';
import 'package:course_guide/controllers/nav_control.dart';
import 'package:course_guide/controllers/notifications.dart';
import 'package:course_guide/firebase_options.dart';
import 'package:course_guide/router.dart';
import 'package:course_guide/views/home/profile/widget/edit_profile_form.dart';
import 'package:course_guide/views/home/universities/guc_form/guc_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

void main() async {
  // ensure binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // init firebase from options
  // lock orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setPathUrlStrategy();

  final Auth auth = Auth();
  await auth.init();

  runApp(MyApp(
    auth: auth,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.auth});

  final Auth auth;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ProfileForm(widget.auth)),
              ChangeNotifierProvider<Auth>.value(
                value: widget.auth,
              ),
              ChangeNotifierProvider(
                create: (_) => NotificationsController(widget.auth),
              ),
              ChangeNotifierProvider(create: (_) => CourseController()),
              ChangeNotifierProvider(create: (_) => NavController()),
              ChangeNotifierProvider(create: (_) => ProfileForm(widget.auth)),
              ChangeNotifierProvider(create: (_) => GucForm(auth: widget.auth)),
            ],
            child: MaterialApp.router(
              title: 'Course Guide',
              theme: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: HexColor('#FFC107'),
                  secondary: HexColor('#FDE84C'),
                ),
              ),
              routerConfig: router,
            ),
          );
        });
  }
}
