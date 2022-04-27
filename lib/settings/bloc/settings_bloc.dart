import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState()) {
    on<IndexChangeEvent>(_onIndexChange);
    on<OldPassChange>(_onOldPassChange);
    on<NewPassChange>(_onNewPassChange);
  }

  void _onIndexChange(
      IndexChangeEvent event,
      Emitter<SettingsState> emit
      )
  {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onOldPassChange(
      OldPassChange event,
      Emitter<SettingsState> emit
      ) {
    emit(state.copyWith(oldPass: event.oldPass));
  }
  void _onNewPassChange(
      NewPassChange event,
      Emitter<SettingsState> emit
      ) {
    emit(state.copyWith(newPass: event.newPass));
  }

}
