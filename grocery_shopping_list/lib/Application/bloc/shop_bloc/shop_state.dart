import 'package:equatable/equatable.dart';
import '/Infrastructure/models/shop.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<Shop> shops;

  ShopLoaded({required this.shops});

  @override
  List<Object> get props => [shops];
}

class ShopError extends ShopState{
  final String message;

  ShopError({required this.message});

  @override
  List<Object> get props => [message];
}
class ShopItemChecked extends ShopState {
  final String shopName;
  final String item;

  ShopItemChecked({required this.shopName, required this.item});
}