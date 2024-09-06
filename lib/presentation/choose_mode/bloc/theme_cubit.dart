import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);


  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeMode.values[json['themeMode'] as int];
    } catch (_) {
      return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'themeMode': state.index};
  }

  void setDarkMode() => emit(ThemeMode.dark);
  void setLightMode() => emit(ThemeMode.light);

  }

