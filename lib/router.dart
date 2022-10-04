import 'package:course_guide/views/authentication/landing.dart';
import 'package:course_guide/views/authentication/sign_in.dart';
import 'package:course_guide/views/authentication/sign_up.dart';
import 'package:course_guide/views/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          path: 'sign-up',
          builder: (BuildContext context, GoRouterState state) =>
              const SignUp(),
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
