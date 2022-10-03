import 'package:course_guide/views/authentication/sign_in.dart';
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
      ],
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const Onboarding(),
    ),
  ],
);
