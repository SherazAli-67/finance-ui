import 'package:finance_ui/presentation/screens/detail_screen.dart';
import 'package:finance_ui/presentation/screens/home_screen.dart';
import 'package:finance_ui/presentation/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => const WelcomeScreen(),),
    GoRoute(path: NamedRoutes.home.routeName, builder: (_, state) => const HomeScreen(),),
    GoRoute(
      path: '${NamedRoutes.detail.routeName}/:id',
      builder: (_, state) => DetailScreen(id: state.pathParameters['id']!,),
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
