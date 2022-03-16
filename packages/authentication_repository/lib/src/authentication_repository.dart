import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, registering }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<http.Response> logIn({
    required String username,
    required String password,
  }) async {

    var status = await Permission.location.request();

    final response = await http.post(
      Uri.parse('http://poirecserver.swedencentral.cloudapp.azure.com/Authentication/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if(response.statusCode == 200){
      _controller.add(AuthenticationStatus.authenticated);
    }

    return response;
  }

  Future<http.Response> register({
    required String username,
    required String password,
    required int gender,
    required String age,
  }) async {

    print(gender);

    final response = await http.post(
      Uri.parse('http://poirecserver.swedencentral.cloudapp.azure.com/Authentication/Register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
        'gender': gender,
        'dateofbirth': age,
      }),
    );

    print(response.body);

    if(response.statusCode == 200){
      _controller.add(AuthenticationStatus.unauthenticated);
    }

    return response;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void goRegister() {
    _controller.add(AuthenticationStatus.registering);
  }

  void dispose() => _controller.close();
}
