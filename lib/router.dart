import 'package:course_guide/views/authentication/forgot_password.dart';
import 'package:course_guide/views/authentication/landing.dart';
import 'package:course_guide/views/authentication/sign_in.dart';
import 'package:course_guide/views/authentication/sign_up.dart';
import 'package:course_guide/views/home/home.dart';
import 'package:course_guide/views/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'controllers/auth.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      routes: <GoRoute>[
        GoRoute(
          path: 'sign-in',
          builder: (BuildContext context, GoRouterState state) =>
              const SignInPage(),
        ),
        GoRoute(
          redirect: (BuildContext context, GoRouterState state) async {
            final auth = Provider.of<Auth>(context, listen: false);
            if (auth.isAuthenticated && state.location == '/home') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Welcome back!'),
                  backgroundColor: Colors.green,
                ),
              );
              return null;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid credentials'),
                ),
              );
              return '/sign-in';
            }
          },
          path: 'home',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeView(),
        ),
        GoRoute(
          path: 'sign-up',
          builder: (BuildContext context, GoRouterState state) =>
              const SignUp(),
        ),
        GoRoute(
          path: 'forgot-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ForgotPasswordPage(),
        ),
        GoRoute(
          path: 'landing',
          builder: (BuildContext context, GoRouterState state) =>
              const Landing(),
        ),
      ],
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const Onboarding(),
    ),
  ],
);
