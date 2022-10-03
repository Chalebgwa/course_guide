import 'package:course_guide/views/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      routes: <GoRoute>[],
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const Onboarding(),
    ),
  ],
);
