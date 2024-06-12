import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../infrastructure/app_database.dart';

final appFloorDBProvider = Provider(
  (ref) => AppFloorDB(),
);
