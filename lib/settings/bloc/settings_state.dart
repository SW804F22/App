part of 'settings_bloc.dart';

class SettingsState extends Equatable {

  const SettingsState({
    this.selectedIndex = 0,
    this.oldPass = "",
    this.newPass = "",
  });

  final String oldPass;
  final String newPass;
  final int selectedIndex;

SettingsState copyWith({
  int? selectedIndex,
  String? oldPass,
  String? newPass,
}) {
  return SettingsState(
  selectedIndex: selectedIndex ?? this.selectedIndex,
  oldPass: oldPass ?? this.oldPass,
  newPass: newPass ?? this.newPass,
  );
}

@override
List<Object> get props => [selectedIndex, oldPass, newPass];
}

