import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetAllTodosUseCase {
  final TodoRepository repository;

  const GetAllTodosUseCase(this.repository);

  Future<List<TodoEntity>> call() async {
    return await repository.getAllTodos();
  }
}
