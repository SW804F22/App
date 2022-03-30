import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/register_bloc.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Failed to register')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _GenderChoice(),
            const Padding(padding: EdgeInsets.all(12)),
            _AgePicker(),
            const Padding(padding: EdgeInsets.all(12)),
            _RegisterButton(),

          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<RegisterBloc>().add(RegisterUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Username',
            errorText: state.username.invalid ? 'invalid username' : null,
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<RegisterBloc>().add(RegisterPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid ? 'invalid password' : null,
            border: OutlineInputBorder(),
          ),
        );
      },
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems{
  final List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(value: "0", child: Text("Unspecified")),
    DropdownMenuItem(value: "1", child: Text("Male")),
    DropdownMenuItem(value: "2", child: Text("Female")),
  ];
  return menuItems;
}

class _GenderChoice extends StatelessWidget {
  String? selected = dropdownItems[0].value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Gender: ", textScaleFactor: 1.5,),
        DropdownButton<String>(
        value: selected,
        items: dropdownItems,
        onChanged: (gender) {
          selected = dropdownItems[int.parse(gender!)].value;
          context.read<RegisterBloc>().add(RegisterGenderChanged(gender));
        },
          borderRadius: BorderRadius.all(Radius.circular(10)),
      ),],
      );
      },
    );
  }
}

class _AgePicker extends StatelessWidget {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2022, 8));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      context.read<RegisterBloc>().add(RegisterAgeChanged(selectedDate.toString().split(' ')[0]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Birthdate: ${selectedDate.toString().split(' ')[0]}"),
          ElevatedButton(onPressed: () => {
            _selectDate(context),
          },
              child: Text("Pick date")),
        ],
      );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.status.isValidated
              ? () {
            context.read<RegisterBloc>().add(const RegisterSubmitted());
          }
              : null,
          style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
          child: const Text('Register'),
        );
      },
    );
  }
}
