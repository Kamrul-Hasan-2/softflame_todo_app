import '../entities/todo_entity.dart';

abstract class TodoRepository {

  Future<List<TodoEntity>> getAllTodos();

  Future<void> addTodo(TodoEntity todo);

  Future<void> updateTodo(TodoEntity todo);

  Future<void> deleteTodo(String id);

  Future<void> toggleTodoStatus(String id);
}
