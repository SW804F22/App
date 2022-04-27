import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poirecapi/authentication/bloc/authentication_bloc.dart';
import 'package:poirecapi/global_styles.dart' as style;
import 'package:poirecapi/settings/bloc/settings_bloc.dart';

class SettingsMain extends StatefulWidget {
  const SettingsMain({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsMain());
  }

  @override
  _SettingsMainState createState() => _SettingsMainState();
}

class _SettingsMainState extends State<SettingsMain> {

  static final List<Widget> _pages = <Widget>[
    Text(""),
    PassChange(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(create: (BuildContext context) => SettingsBloc(),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) => previous.selectedIndex != current.selectedIndex,
          builder: (context, state) {
            return Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                        if(state.selectedIndex == 1){
                          context.read<SettingsBloc>().add(IndexChangeEvent(0))
                        }
                        else{
                          context.read<SettingsBloc>().add(IndexChangeEvent(1))
                        },
                      },
                      child: Text("Change Password"),
                      style: ElevatedButton.styleFrom(primary: style.primary),
                  ),
                  IndexedStack(
                    index: state.selectedIndex,
                    children: _pages,
                  ),
                  ElevatedButton(onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
                    child: Text("Logout"),
                    style: ElevatedButton.styleFrom(primary: style.primary),

                  )
                ],
            ),
            );
      },
    ));
    }
  }

class PassChange extends StatelessWidget {
  const PassChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.all(12)),
            TextField(
              onChanged: (oldPass) => context.read<SettingsBloc>().add(OldPassChange(oldPass)),
              decoration: InputDecoration(
                labelText: 'Old password',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.all(12)),
            TextField(
              onChanged: (newPass) => context.read<SettingsBloc>().add(NewPassChange(newPass)),
              decoration: InputDecoration(
                labelText: 'New password',
                border: OutlineInputBorder(),
              ),
            ),
            Padding(padding: EdgeInsets.all(12)),
            ElevatedButton(onPressed: () => {}, child: Text("Submit"), style: ElevatedButton.styleFrom(primary: style.primary),
            )
          ],
        );
      },
    );
  }
}
