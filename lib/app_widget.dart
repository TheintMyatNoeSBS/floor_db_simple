import 'package:dartz/dartz.dart';
import 'package:floor_db_simple/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/shared/core_provider.dart';

final initializationProvider = FutureProvider<Unit>(
  (ref) async {
    await ref.read(appFloorDBProvider).init();

    return unit;
  },
);

class AppWidget extends ConsumerWidget {
  AppWidget({
    super.key,
  });

  static const String tag = 'AppWidget';

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Simple Floor Database',
      debugShowCheckedModeBanner: false,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
    );
  }
}
