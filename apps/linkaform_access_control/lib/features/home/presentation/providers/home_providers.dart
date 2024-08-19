import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/features/start_turn/domain/entities/booth_entity.dart';
import 'package:linkaform_access_control/features/start_turn/domain/entities/load_shift_entity.dart';

final guardHouseValueProvider = StateProvider<String>(
  (ref) => 'Planta Monterrey - Caseta 6 Poniente',
);

final guardHouseSelectedValueProvider = StateProvider<BoothData?>(
  (ref) => BoothData.empty(),
);

final guardHouseListProvider = StateProvider<List<BoothData>>(
  (ref) => [],
);

final guardListProvider = StateProvider<List<SupportGuard>>(
  (ref) => [],
);

final guardSelectedValueProvider = StateProvider<String?>(
  (ref) => null,
);
