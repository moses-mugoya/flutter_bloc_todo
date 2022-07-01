part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class LoadActivityEvent extends ActivityEvent{}

class AddActivityEvent extends ActivityEvent{
  final String name;
  final String description;

  AddActivityEvent(this.name, this.description);

  
}
