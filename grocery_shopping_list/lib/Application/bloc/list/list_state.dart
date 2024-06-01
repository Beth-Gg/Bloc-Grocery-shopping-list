// import 'package:equatable/equatable.dart';
// import '../../../Infrastructure/models/list.dart';


// @override
// abstract class GroceryListState extends Equatable {
//   const GroceryListState();

//   @override
//   List<Object> get props => [];
// }

// class GroceryListInitial extends GroceryListState {}

// class GroceryListLoading extends GroceryListState {}

// class GroceryListLoaded extends GroceryListState {
//   final List<GroceryList> lists;

//   const GroceryListLoaded({required this.lists});

//   @override
//   List<Object> get props => [lists];
// }

// class GroceryListError extends GroceryListState {
//   final String message;

//   const GroceryListError({required this.message});

//   @override
//   List<Object> get props => [message];
// }

import 'package:equatable/equatable.dart';
import '../../../Infrastructure/models/list.dart';

abstract class GroceryListState extends Equatable {
  const GroceryListState();

  @override
  List<Object> get props => [];
}

class GroceryListInitial extends GroceryListState {}

class GroceryListLoading extends GroceryListState {}

class GroceryListLoaded extends GroceryListState {
  final List<GroceryList> lists;

  const GroceryListLoaded({required this.lists});

  @override
  List<Object> get props => [lists];
}

class GroceryListError extends GroceryListState {
  final String message;

  const GroceryListError({required this.message});

  @override
  List<Object> get props => [message];
}
