import '../repositories/todo_repository.dart';

class ToggleTodoStatusUseCase {
  final TodoRepository repository;

  const ToggleTodoStatusUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.toggleTodoStatus(id);
  }
}
