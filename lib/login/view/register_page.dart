import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poirecapi/global_styles.dart' as style;
import 'package:poirecapi/login/view/register_form.dart';
import '../bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child: const Text('Register             ')),
        backgroundColor: style.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: style.secondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: BlocProvider(
            create: (context) {
              return RegisterBloc(
                authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}
