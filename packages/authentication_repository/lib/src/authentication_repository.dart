import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, registering }
enum PassChangeStatus { unknown, succeeded, failed }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _controllerPass = StreamController<PassChangeStatus>();

  late final String userId;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Stream<PassChangeStatus> get passStatus async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield PassChangeStatus.unknown;
    yield* _controllerPass.stream;
  }

  Future<http.Response> logIn({
    required String username,
    required String password,
  }) async {

    await Permission.location.request();

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
      userId = json.decode(response.body)['id'];
    }

    return response;
  }

  Future<http.Response> register({
    required String username,
    required String password,
    required int gender,
    required String age,
  }) async {
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

    if(response.statusCode == 201){
      _controller.add(AuthenticationStatus.unauthenticated);
    }

    return response;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void goRegister() {
    _controller.add(AuthenticationStatus.registering);
    _controller.add(AuthenticationStatus.unknown);
  }

  void changedPasswordSucceeded() {
    _controllerPass.add(PassChangeStatus.succeeded);
  }

  void changedPasswordFailed() {
    _controllerPass.add(PassChangeStatus.failed);
  }

  Future<List> returnMarkers(double lat, double long) async{

    final response = await http.get(
        Uri.parse('http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?latitude=$lat&longitude=$long&distance=0.01&limit=1000'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if(response.statusCode == 404){
      return List.empty();
    }
    return json.decode(response.body) as List;
  }

  Future<http.Response> changePassword(String oldPass, String newPass) async {
    final response = await http.post(
        Uri.parse('http://poirecserver.swedencentral.cloudapp.azure.com/Authentication/Password/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
        'oldPassword': oldPass,
        'newPassword': newPass,
    }),
    );

    return response;
  }

  void dispose() => {_controller.close(), _controllerPass.close()};
}
