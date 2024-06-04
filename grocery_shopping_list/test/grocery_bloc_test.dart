import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../lib/Application/bloc/list/list_bloc.dart';
import '../lib/Application/bloc/list/list_event.dart';
import '../lib/Application/bloc/list/list_state.dart';
import '../lib/Infrastructure/repositories/list_repository.dart';

class MockListRepository extends Mock implements ListRepository {}

void main() {
  group('GroceryListBloc', () {
    late MockListRepository listRepository;

    setUp(() {
      listRepository = MockListRepository();

      // Stubbing the methods of listRepository
      when(listRepository.addList('2022-01-01', 'Test content')).thenAnswer((_) async => 'List added successfully');
      when(listRepository.editList('1', '2022-01-01', 'Test content')).thenAnswer((_) async => 'List edited successfully');
      when(listRepository.deleteList('1')).thenAnswer((_) async => 'List deleted successfully');
    });

    tearDown(() {
      // Ensure all interactions with the mock repository are verified
      verifyNoMoreInteractions(listRepository);
    });

    test('initial state is GroceryListInitial', () {
      final bloc = GroceryListBloc(listRepository: listRepository);
      expect(bloc.state, GroceryListInitial());
    });

    blocTest<GroceryListBloc, GroceryListState>(
      'emits [GroceryListLoading, GroceryListLoaded] when AddAddListEvent is added',
      build: () => GroceryListBloc(listRepository: listRepository),
      act: (bloc) => bloc.add(AddAddListEvent(date: '2022-01-01', content: 'Test content')),
      expect: () => [
        GroceryListLoading(),
        GroceryListLoaded(lists: []),
      ],
      verify: (bloc) {
        verify(listRepository.addList('2022-01-01', 'Test content')).called(1);
        verify(listRepository.fetchAllLists()).called(1);
      },
    );

    blocTest<GroceryListBloc, GroceryListState>(
      'emits [GroceryListLoading, GroceryListLoaded] when EditListEvent is added',
      build: () => GroceryListBloc(listRepository: listRepository),
      act: (bloc) => bloc.add(EditListEvent(id: '1', date: '2022-01-01', content: 'Test content')),
      expect: () => [
        GroceryListLoading(),
        GroceryListLoaded(lists: []),
      ],
      verify: (bloc) {
        verify(listRepository.editList('1', '2022-01-01', 'Test content')).called(1);
        verify(listRepository.fetchAllLists()).called(1);
      },
    );

    blocTest<GroceryListBloc, GroceryListState>(
      'emits [GroceryListLoading, GroceryListLoaded] when DeleteListEvent is added',
      build: () => GroceryListBloc(listRepository: listRepository),
      act: (bloc) => bloc.add(DeleteListEvent(id: '1')),
      expect: () => [
        GroceryListLoading(),
        GroceryListLoaded(lists: []),
      ],
      verify: (bloc) {
        verify(listRepository.deleteList('1')).called(1);
        verify(listRepository.fetchAllLists()).called(1);
      },
    );

    blocTest<GroceryListBloc, GroceryListState>(
      'emits GroceryListError when an error occurs',
      build: () => GroceryListBloc(listRepository: listRepository),
      act: (bloc) {
        // Stubbing listRepository.addList to throw an error
        when(listRepository.addList('2022-01-01', 'Test content')).thenThrow(Exception('Error'));
        bloc.add(AddAddListEvent(date: '2022-01-01', content: 'Test content'));
      },
      expect: () => [
        GroceryListLoading(),
        GroceryListError(message: 'Error'),
      ],
      verify: (bloc) {
        verify(listRepository.addList('2022-01-01', 'Test content')).called(1);
        // Since an error occurred, fetchAllLists should not be called
        verifyNever(listRepository.fetchAllLists());
      },
    );
  });
}
