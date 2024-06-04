import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:signup/Infrastructure/repositories/shop_repository.dart';
import 'package:signup/Infrastructure/models/shop.dart';
import 'package:signup/Application/bloc/shop_bloc/shop_bloc.dart';
import 'package:signup/Application/bloc/shop_bloc/shop_event.dart';
import 'package:signup/Application/bloc/shop_bloc/shop_state.dart';

class MockShopRepository extends Mock implements ShopRepository {}

void main() {
  group('ShopBloc', () {
    late MockShopRepository shopRepository;
    late ShopBloc shopBloc;

    setUp(() {
      shopRepository = MockShopRepository();
      shopBloc = ShopBloc();
    });

    tearDown(() {
      shopBloc.close();
    });

    test('initial state is ShopInitial', () {
      expect(shopBloc.state, ShopInitial());
    });

    blocTest<ShopBloc, ShopState>(
      'emits [ShopLoading, ShopLoaded] when LoadShops is added',
      build: () {
        when(shopRepository.fetchShops()).thenAnswer((_) async => [
          Shop(id: '1', name: 'Shop 1', items: ['Item 1', 'Item 2']),
          Shop(id: '2', name: 'Shop 2', items: ['Item 3', 'Item 4']),
        ]);
        return shopBloc;
      },
      act: (bloc) async {
        bloc.add(LoadShops());
      },
      expect: () => [
        ShopLoading(),
        ShopLoaded(shops: [
          Shop(id: '1', name: 'Shop 1', items: ['Item 1', 'Item 2']),
          Shop(id: '2', name: 'Shop 2', items: ['Item 3', 'Item 4']),
        ]),
      ],
    );

    blocTest<ShopBloc, ShopState>(
      'emits [ShopLoading, ShopError] when LoadShops fails',
      build: () {
        when(shopRepository.fetchShops()).thenThrow(Exception('Error fetching shops'));
        return shopBloc;
      },
      act: (bloc) async {
        bloc.add(LoadShops());
      },
      expect: () => [
        ShopLoading(),
        ShopError(message: 'Error fetching shops'),
      ],
    );
  });
}