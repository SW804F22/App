import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../models/password.dart';
import '../models/username.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
required AuthenticationRepository authenticationRepository,
})  : _authenticationRepository = authenticationRepository,
super(const RegisterState()) {
  on<RegisterUsernameChanged>(_onUsernameChanged);
  on<RegisterPasswordChanged>(_onPasswordChanged);
  on<RegisterSubmitted>(_onSubmitted);
  on<RegisterGenderChanged>(_onGenderChanged);
  on<RegisterAgeChanged>(_onAgeChanged);
  on<GoBackEvent>(_goBack);
}

final AuthenticationRepository _authenticationRepository;

void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
    ) {
  final username = Username.dirty(event.username);
  emit(state.copyWith(
    username: username,
    status: Formz.validate([state.password, username]),
  ));
}

void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
    ) {
  final password = Password.dirty(event.password);
  emit(state.copyWith(
    password: password,
    status: Formz.validate([password, state.username]),
  ));
}
void _onGenderChanged(
    RegisterGenderChanged event,
    Emitter<RegisterState> emit,
    ) {
  final gender = event.gender;
  emit(state.copyWith(
    gender: gender,
  ));
}

void _onAgeChanged(
    RegisterAgeChanged event,
    Emitter<RegisterState> emit,
    ) {
  final age = event.age;
  emit(state.copyWith(
    age: age,
  ));
}

void _goBack(
    GoBackEvent event,
    Emitter<RegisterState> emit,
    ) async {
  _authenticationRepository.logOut();
}

void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
    ) async {
  if (state.status.isValidated) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final response = await _authenticationRepository.register(
        username: state.username.value,
        password: state.password.value,
        gender: int.parse(state.gender),
        age: state.age,
      );
      if(response.statusCode != 201) {
        throw Future.error("Failed to register. Status code: ${response.statusCode}");
      } else {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
}
