part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUsernameChanged extends RegisterEvent {
  const RegisterUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class RegisterGenderChanged extends RegisterEvent {
  const RegisterGenderChanged(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class RegisterAgeChanged extends RegisterEvent {
  const RegisterAgeChanged(this.age);

  final String age;

  @override
  List<Object> get props => [age];
}