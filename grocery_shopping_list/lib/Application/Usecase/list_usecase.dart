import '../../Infrastructure/repositories/list_repository.dart';
import '/Infrastructure/models/list.dart';


abstract class ListUsecase {
  Future<List<GroceryList>> fetchAllLists();
  Future<String> addList(String date, String content);
  Future<void> editList(String id, String date, String content);
  Future<void> deleteList(String id);
  Future<List<GroceryList>> getLists();
}

class ListUsecaseImpl implements ListUsecase {
  final ListRepository _listRepository;

  ListUsecaseImpl({required ListRepository listRepository})
      : _listRepository = listRepository;

  @override
  Future<List<GroceryList>> fetchAllLists() async {
    return _listRepository.fetchAllLists();
  }

  @override
  Future<String> addList(String date, String content) async {
    return _listRepository.addList(date, content);
  }

  @override
  Future<void> editList(String id, String date, String content) async {
    return _listRepository.editList(id, date, content);
  }

  @override
  Future<void> deleteList(String id) async {
    return _listRepository.deleteList(id);
  }
  @override
  Future<List<GroceryList>> getLists() async {
    return _listRepository.fetchAllLists(); 
  }
}