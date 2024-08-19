import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform_access_control/core/services/dio_service.dart';
import 'package:linkaform_access_control/core/services/shared_preferences_service.dart';
import 'package:linkaform_access_control/features/scanner/domain/entities/entry_passes_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

final entryPassesProvider =
    StateNotifierProvider<EntryPassesNotifier, EntryPassesState>(
  (ref) => EntryPassesNotifier(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    apiClient: ref.watch(apiCallProvider),
  ),
);

enum EntryPassesStatus { initial, loading, loaded, error }

class EntryPassesState {
  const EntryPassesState({
    this.status = EntryPassesStatus.initial,
    this.passes,
  });

  final EntryPassesStatus status;
  final EntryPass? passes;

  EntryPassesState copyWith({
    EntryPassesStatus? status,
    EntryPass? passes,
  }) {
    return EntryPassesState(
      status: status ?? this.status,
      passes: passes ?? this.passes,
    );
  }
}

class EntryPassesNotifier extends StateNotifier<EntryPassesState> {
  EntryPassesNotifier({
    required this.sharedPreferences,
    required this.apiClient,
  }) : super(const EntryPassesState());

  final SharedPreferences sharedPreferences;
  final DioMethods apiClient;

  Future<void> getEntryPasses() async {
    try {
      state = state.copyWith(status: EntryPassesStatus.loading);
      final response = await apiClient.post(
        url: 'scripts/run/',
        body: {
          'option': 'search_access_pass',
          'script_name': 'script_turnos.py',
          'location': 'Planta Monterrey',
          'qr_code': '66a9556db265f4fb4f9984c6'
        },
      );

      response.fold(
          (failure) => state = state.copyWith(status: EntryPassesStatus.error),
          (success) {
        final entryPasses = EntryPass.fromJson(
          jsonEncode(success as String) as Map<String, dynamic>,
        );

        state = state.copyWith(
            passes: entryPasses, status: EntryPassesStatus.loaded);
      });
    } catch (e) {
      state = state.copyWith(status: EntryPassesStatus.error);
    }
  }
}
