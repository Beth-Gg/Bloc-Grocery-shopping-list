
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Infrastructure/models/shop.dart';
import '../../../Infrastructure/repositories/shop_repository.dart';
import 'shop_state.dart';
import 'shop_event.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _shopRepository = ShopRepository();

  ShopBloc() : super(ShopInitial()) {
    on<LoadShops>(_onLoadShops);
  }

void _onLoadShops(LoadShops event, Emitter<ShopState> emit) async {
  emit(ShopLoading()); // Yield a loading state while fetching shops
  try {
    final List<Shop> shops = await _shopRepository.fetchShops();
    emit(ShopLoaded(shops: shops));
  } catch (e) {
    print('Error fetching shops: $e'); // Add this line
    emit(ShopError(message: e.toString())); // Emit the error state
  }
}



}
