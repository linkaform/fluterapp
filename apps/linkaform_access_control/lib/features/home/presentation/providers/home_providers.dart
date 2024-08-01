import 'package:flutter_riverpod/flutter_riverpod.dart';

final guardHouseValueProvider = StateProvider<String>(
  (ref) => 'Planta Monterrey - Caseta 6 Poniente',
);

final guardHouseSelectedValueProvider = StateProvider<String?>(
  (ref) => null,
);

final guardHouseListProvider = StateProvider<List<String>>(
  (ref) => [
    'Planta Monterrey - Caseta 1 Poniente',
    'Planta Monterrey - Caseta 2 Poniente',
    'Planta Monterrey - Caseta 3 Poniente',
    'Planta Monterrey - Caseta 4 Poniente',
    'Planta Monterrey - Caseta 5 Poniente',
    'Planta Monterrey - Caseta 6 Poniente',
    'Otra Ubicación',
  ],
);

final guardListProvider = StateProvider<List<String>>(
  (ref) => [
    'Fernando López García',
    'Juan Carlos Rodríguez Martínez',
  ],
);

final guardSelectedValueProvider = StateProvider<String?>(
  (ref) => null,
);
