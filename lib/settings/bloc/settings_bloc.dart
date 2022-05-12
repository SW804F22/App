import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required AuthenticationRepository authenticationRepository,
  }) :  _authenticationRepository = authenticationRepository,
        super(SettingsState()) {
    on<IndexChangeEvent>(_onIndexChange);
    on<OldPassChange>(_onOldPassChange);
    on<NewPassChange>(_onNewPassChange);
    on<SubmitPassChange>(_onPassChangeSubmit);
  }

  final AuthenticationRepository _authenticationRepository;

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

  void _onPassChangeSubmit(
      SubmitPassChange event,
      Emitter<SettingsState> emit
      ) async {
      final response = await _authenticationRepository.changePassword(event.oldPass, event.newPass);
      if(response.statusCode == 200){
        _authenticationRepository.changedPasswordSucceeded();
        emit(state.copyWith(status: PassChangeStatus.succeeded));
        emit(state.copyWith(status: PassChangeStatus.unknown));
      }
      else {
        _authenticationRepository.changedPasswordFailed();
        emit(state.copyWith(status: PassChangeStatus.failed));
        emit(state.copyWith(status: PassChangeStatus.unknown));
      }
  }

}
