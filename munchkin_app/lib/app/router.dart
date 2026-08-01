import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/room/create_room_screen.dart';
import '../features/room/join_room_screen.dart';
import '../features/room/room_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreateRoomScreen(),
    ),
    GoRoute(path: '/join', builder: (context, state) => const JoinRoomScreen()),
    GoRoute(path: '/room', builder: (context, state) => const RoomScreen()),
  ],
);
