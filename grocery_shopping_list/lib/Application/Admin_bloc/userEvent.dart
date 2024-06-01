// user_event.dart
import 'package:equatable/equatable.dart';
import 'user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class EditUser extends UserEvent {
  final int index;
  final User user;

  const EditUser(this.index, this.user);

  @override
  List<Object> get props => [index, user];
}

class DeleteUser extends UserEvent {
  final int index;

  const DeleteUser(this.index);

  @override
  List<Object> get props => [index];
}
