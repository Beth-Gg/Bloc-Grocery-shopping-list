import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class LoadShops extends ShopEvent {}
class ToggleItemCheckbox extends ShopEvent {
  final String shopName;
  final String item;
  final bool isChecked; 

  ToggleItemCheckbox({required this.shopName, required this.item, required this.isChecked});
}