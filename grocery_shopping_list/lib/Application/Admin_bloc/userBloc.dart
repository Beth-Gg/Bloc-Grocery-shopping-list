
// user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'userEvent.dart';
import 'userState.dart';
import 'user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      await Future.delayed(Duration(seconds: 1));
      emit(UserLoaded([]));
    });

    on<AddUser>((event, emit) {
      if (state is UserLoaded) {
        final List<User> updatedUsers = List.from((state as UserLoaded).users)
          ..add(event.user);
        emit(UserLoaded(updatedUsers));
      }
    });

    on<EditUser>((event, emit) {
      if (state is UserLoaded) {
        final List<User> updatedUsers = List.from((state as UserLoaded).users)
          ..[event.index] = event.user;
        emit(UserLoaded(updatedUsers));
      }
    });

    on<DeleteUser>((event, emit) {
      if (state is UserLoaded) {
        final List<User> updatedUsers = List.from((state as UserLoaded).users)
          ..removeAt(event.index);
        emit(UserLoaded(updatedUsers));
      }
    });
  }
}


