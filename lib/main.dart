import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:poi_repository/poi_repository.dart';
import 'package:poirecapi/app.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  //Load env variables
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    poiRepository: PoiRepository(),
  ));
}
