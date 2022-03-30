part of 'register_bloc.dart';

class RegisterState extends Equatable {
const RegisterState({
this.status = FormzStatus.pure,
this.username = const Username.pure(),
this.password = const Password.pure(),
this.gender = "0",
this.age = "",
});

final FormzStatus status;
final Username username;
final Password password;
final String gender;
final String age;

RegisterState copyWith({
  FormzStatus? status,
  Username? username,
  Password? password,
  String? gender,
  String? age,
}) {
  return RegisterState(
    status: status ?? this.status,
    username: username ?? this.username,
    password: password ?? this.password,
    gender: gender ?? this.gender,
    age: age ?? this.age,
  );
}

@override
List<Object> get props => [status, username, password, gender, age];
}