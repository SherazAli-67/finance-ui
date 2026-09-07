import 'package:finance_ui/presentation/screens/detail_screen.dart';
import 'package:finance_ui/presentation/screens/home_screen.dart';
import 'package:finance_ui/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => const WelcomeScreen(),),
    GoRoute(path: NamedRoutes.home.routeName, builder: (_, state) => const HomeScreen(),),
    GoRoute(
      path: '${NamedRoutes.detail.routeName}/:id',
      pageBuilder: (_, state) => CustomTransitionPage(
        key: state.pageKey,
        child: DetailScreen(id: state.pathParameters['id']!,),
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          child: SlideTransition(
            position: Tween(begin: const Offset(0.05, 0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
      ),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  detail('/detail');

  final String routeName;
  const NamedRoutes(this.routeName);
}
