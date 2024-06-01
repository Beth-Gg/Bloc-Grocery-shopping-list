// import 'dart:async';
// import 'list_event.dart';
// import 'list_state.dart';
// import '../../../Infrastructure/repositories/cart_repository.dart';
// import '/Application/Usecase/list_usecase.dart';
// import '../../../Infrastructure/models/list.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class GroceryListBloc extends Bloc<GroceryListEvent, GroceryListState> {
//   final ListRepository listRepository;

//   GroceryListBloc({required this.listRepository}) : super(GroceryListInitial()) {
//     on<AddAddListEvent>(_mapAddAddListEventToState);
//     on<EditListEvent>(_mapEditListEventToState);
//     on<DeleteListEvent>(_mapDeleteListEventToState);
//   }

//   void _mapAddAddListEventToState(AddAddListEvent event, Emitter<GroceryListState> emit) async {
//     emit(GroceryListLoading());
//     try {
//       final id = await listRepository.addList(event.date, event.content);
//       final lists = await listRepository.fetchAllLists();
//       emit(GroceryListLoaded(lists: lists));
//     } catch (e) {
//       emit(GroceryListError(message: e.toString()));
//     }
//   }

//   void _mapEditListEventToState(EditListEvent event, Emitter<GroceryListState> emit) async {
//     emit(GroceryListLoading());
//     try {
//       await listRepository.editList(event.id, event.date, event.content);
//       final lists = await listRepository.fetchAllLists();
//       emit(GroceryListLoaded(lists: lists));
//     } catch (e) {
//       emit(GroceryListError(message: e.toString()));
//     }
//   }

//   void _mapDeleteListEventToState(DeleteListEvent event, Emitter<GroceryListState> emit) async {
//     emit(GroceryListLoading());
//     try {
//       await listRepository.deleteList(event.id);
//       final lists = await listRepository.fetchAllLists();
//       emit(GroceryListLoaded(lists: lists));
//     } catch (e) {
//       emit(GroceryListError(message: e.toString()));
//     }
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Infrastructure/models/list.dart';
import '../../../Infrastructure/repositories/list_repository.dart';
import 'list_event.dart';
import 'list_state.dart';

class GroceryListBloc extends Bloc<GroceryListEvent, GroceryListState> {
  final ListRepository listRepository;

  GroceryListBloc({required this.listRepository}) : super(GroceryListInitial()) {
    on<LoadListsEvent>(_mapLoadListsEventToState);
    on<AddAddListEvent>(_mapAddAddListEventToState);
    on<EditListEvent>(_mapEditListEventToState);
    on<DeleteListEvent>(_mapDeleteListEventToState);
  }

  void _mapLoadListsEventToState(LoadListsEvent event, Emitter<GroceryListState> emit) async {
    emit(GroceryListLoading());
    try {
      final lists = await listRepository.fetchAllLists();
      emit(GroceryListLoaded(lists: lists));
    } catch (e) {
      emit(GroceryListError(message: e.toString()));
    }
  }

  void _mapAddAddListEventToState(AddAddListEvent event, Emitter<GroceryListState> emit) async {
    emit(GroceryListLoading());
    try {
      await listRepository.addList(event.date, event.content);
      final lists = await listRepository.fetchAllLists();
      emit(GroceryListLoaded(lists: lists));
    } catch (e) {
      emit(GroceryListError(message: e.toString()));
    }
  }

  void _mapEditListEventToState(EditListEvent event, Emitter<GroceryListState> emit) async {
    emit(GroceryListLoading());
    try {
      await listRepository.editList(event.id, event.date, event.content);
      final lists = await listRepository.fetchAllLists();
      emit(GroceryListLoaded(lists: lists));
    } catch (e) {
      emit(GroceryListError(message: e.toString()));
    }
  }

  void _mapDeleteListEventToState(DeleteListEvent event, Emitter<GroceryListState> emit) async {
    emit(GroceryListLoading());
    try {
      await listRepository.deleteList(event.id);
      final lists = await listRepository.fetchAllLists();
      emit(GroceryListLoaded(lists: lists));
    } catch (e) {
      emit(GroceryListError(message: e.toString()));
    }
  }
}
