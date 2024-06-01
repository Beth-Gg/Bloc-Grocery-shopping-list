// import 'package:equatable/equatable.dart';
// @override
// abstract class GroceryListEvent extends Equatable {
//   const GroceryListEvent();

//   @override
//   List<Object> get props => [];
// }

// class AddAddListEvent extends GroceryListEvent {
//   final String date;
//   final String content;

//   const AddAddListEvent({required this.date, required this.content});

//   @override
//   List<Object> get props => [date, content];
// }

// class EditListEvent extends GroceryListEvent {
//   final String id;
//   final String date;
//   final String content;

//   const EditListEvent({required this.id, required this.date, required this.content});

//   @override
//   List<Object> get props => [id, date, content];
// }

// class DeleteListEvent extends GroceryListEvent {
//   final String id;

//   const DeleteListEvent({required this.id});

//   @override
//   List<Object> get props => [id];
// }

import 'package:equatable/equatable.dart';

abstract class GroceryListEvent extends Equatable {
  const GroceryListEvent();

  @override
  List<Object> get props => [];
}

class LoadListsEvent extends GroceryListEvent {}

class AddAddListEvent extends GroceryListEvent {
  final String date;
  final String content;

  const AddAddListEvent({required this.date, required this.content});

  @override
  List<Object> get props => [date, content];
}

class EditListEvent extends GroceryListEvent {
  final String id;
  final String date;
  final String content;

  const EditListEvent({required this.id, required this.date, required this.content});

  @override
  List<Object> get props => [id, date, content];
}

class DeleteListEvent extends GroceryListEvent {
  final String id;

  const DeleteListEvent({required this.id});

  @override
  List<Object> get props => [id];
}
