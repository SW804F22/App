part of 'settings_bloc.dart';

class SettingsState extends Equatable {

  const SettingsState({
    this.selectedIndex = 0,
    this.oldPass = "",
    this.newPass = "",
    this.status = PassChangeStatus.unknown,
  });

  final String oldPass;
  final String newPass;
  final int selectedIndex;
  final PassChangeStatus status;

SettingsState copyWith({
  int? selectedIndex,
  String? oldPass,
  String? newPass,
  PassChangeStatus? status,
}) {
  return SettingsState(
  selectedIndex: selectedIndex ?? this.selectedIndex,
  oldPass: oldPass ?? this.oldPass,
  newPass: newPass ?? this.newPass,
  status: status ?? this.status,
  );
}

@override
List<Object> get props => [selectedIndex, oldPass, newPass, status];
}

