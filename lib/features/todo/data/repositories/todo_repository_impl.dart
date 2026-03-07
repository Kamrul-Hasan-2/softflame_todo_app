import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  const TodoRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<TodoEntity>> getAllTodos() async {
    final todoModels = await localDataSource.getAllTodos();
    return todoModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await localDataSource.addTodo(todoModel);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await localDataSource.updateTodo(todoModel);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localDataSource.deleteTodo(id);
  }

  @override
  Future<void> toggleTodoStatus(String id) async {
    await localDataSource.toggleTodoStatus(id);
  }
}
