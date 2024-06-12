import 'package:floor_db_simple/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_initialization.dart';

void main() async {
  await beforeInitialize();
  runApp(ProviderScope(
    child: AppWidget(),
  ));
}
