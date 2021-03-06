import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poirecapi/global_styles.dart' as style;

import '../bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child: const Text('Login')),
        backgroundColor: style.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
          child: LoginForm(),
        ),
      ),
      ),
    );
  }
}
