part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable{
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class IndexChangeEvent extends SettingsEvent {
  const IndexChangeEvent(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class OldPassChange extends SettingsEvent {
  const OldPassChange(this.oldPass);

  final String oldPass;

  @override
  List<Object> get props => [oldPass];
}

class NewPassChange extends SettingsEvent {
  const NewPassChange(this.newPass);

  final String newPass;

  @override
  List<Object> get props => [newPass];
}
