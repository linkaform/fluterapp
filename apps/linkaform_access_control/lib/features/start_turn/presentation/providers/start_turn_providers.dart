import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/core/services/dio_service.dart';
import 'package:linkaform_access_control/core/services/shared_preferences_service.dart';
import 'package:linkaform_access_control/features/home/presentation/providers/home_providers.dart';
import 'package:linkaform_access_control/features/start_turn/domain/entities/booth_entity.dart';
import 'package:linkaform_access_control/features/start_turn/domain/entities/load_shift_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoadShiftState { loading, loaded, error }

enum ChangeBothState { loading, loaded, error }

enum GuardStatus {
  active('Activo'),
  inactive('Inactivo');

  final String status;

  const GuardStatus(this.status);
}

final startTurnProvider =
    StateNotifierProvider<StartTurnNotifier, StartTurnState>(
  (ref) => StartTurnNotifier(
    ref: ref,
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    apiHandler: ref.watch(apiCallProvider),
  ),
);

class StartTurnNotifier extends StateNotifier<StartTurnState> {
  StartTurnNotifier({
    required this.sharedPreferences,
    required this.apiHandler,
    required this.ref,
  }) : super(StartTurnState());

  final SharedPreferences sharedPreferences;
  final DioMethods apiHandler;
  final StateNotifierProviderRef<StartTurnNotifier, StartTurnState> ref;

  Future<void> initialize() async {
    try {
      state = state.copyWith(loadShiftState: LoadShiftState.loading);
      final loadShift = await apiHandler.post(
        url: 'scripts/run/',
        body: {
          'option': 'load_shift',
          'script_name': 'script_turnos.py',
          'area': 'Caseta Principal',
          'location': 'Planta Monterrey',
        },
      );

      loadShift.fold(
        (error) => state = state.copyWith(loadShiftState: LoadShiftState.error),
        (response) {
          ref.read(guardHouseValueProvider.notifier).state =
              state.loadShiftEntity?.data?.guard?.location ?? '';

          ref.read(guardListProvider.notifier).state = state
                  .loadShiftEntity?.data?.supportGuards
                  ?.map((guard) => guard)
                  .toList() ??
              [];

          final shiftEntity = LoadShiftEntity.fromJson(
            jsonDecode(response as String) as Map<String, dynamic>,
          );

          state = state.copyWith(
            loadShiftState: LoadShiftState.loaded,
            loadShiftEntity: shiftEntity,
            supportGuards: shiftEntity.data?.supportGuards,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(loadShiftState: LoadShiftState.error);
    }
  }

  void selectGuard({
    SupportGuard? chosenGuard,
    bool? isSelected,
  }) {
    final updatedList = state.supportGuards
        ?.map(
          (guard) => guard.userId == chosenGuard?.userId
              ? guard = guard.copyWith(
                  isSelected: isSelected,
                  status: guard.status == 'in' ? 'out' : 'in',
                )
              : guard,
        )
        .toList();

    state = state.copyWith(
      supportGuards: updatedList,
    );
  }

  void changeBothState({required ChangeBothState changeBothState}) {
    state = state.copyWith(changeBothState: changeBothState);
  }

  Future<void> changeBoth() async {
    state = state.copyWith(changeBothState: ChangeBothState.loading);
    final getUserBooths = await apiHandler.post(
      url: 'scripts/run/',
      body: {
        'option': 'get_user_booths',
        'script_name': 'script_turnos.py',
      },
    );

    getUserBooths.fold(
      (left) => state = state.copyWith(changeBothState: ChangeBothState.error),
      (success) {
        final boothList = BothEntity.fromJson(
          jsonDecode(success as String) as Map<String, dynamic>,
        );
        ref.read(guardHouseListProvider.notifier).state = boothList.data;
        state = state.copyWith(changeBothState: ChangeBothState.loaded);
      },
    );
  }

  Future<void> forceCloseBooth() async {
    state = state.copyWith(loadShiftState: LoadShiftState.loading);
    final chosenBoth = ref.read(guardHouseSelectedValueProvider);
    final forceCloseBooth = await apiHandler.post(
      url: 'scripts/run/',
      body: {
        'option': 'checkout',
        'script_name': 'script_turnos.py',
        "location": chosenBoth?.location,
        "area": chosenBoth?.area,
        'checkin_id': state.loadShiftEntity?.data?.boothStatus?.checkinId,
      },
    );

    forceCloseBooth.fold(
      (error) => state = state.copyWith(loadShiftState: LoadShiftState.error),
      (success) async => initialize(),
    );
  }
}

class StartTurnState {
  StartTurnState({
    this.loadShiftState,
    this.changeBothState,
    this.loadShiftEntity,
    this.supportGuards,
  });

  final LoadShiftState? loadShiftState;
  final ChangeBothState? changeBothState;
  final LoadShiftEntity? loadShiftEntity;
  final List<SupportGuard>? supportGuards;

  StartTurnState copyWith({
    LoadShiftState? loadShiftState,
    ChangeBothState? changeBothState,
    LoadShiftEntity? loadShiftEntity,
    List<SupportGuard>? supportGuards,
  }) {
    return StartTurnState(
      loadShiftState: loadShiftState ?? this.loadShiftState,
      changeBothState: changeBothState ?? this.changeBothState,
      loadShiftEntity: loadShiftEntity ?? this.loadShiftEntity,
      supportGuards: supportGuards ?? this.supportGuards,
    );
  }
}
