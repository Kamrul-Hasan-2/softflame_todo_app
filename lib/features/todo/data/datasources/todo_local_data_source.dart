import '../models/todo_model.dart';

class TodoLocalDataSource {
  final List<TodoModel> _todos = [];

  Future<List<TodoModel>> getAllTodos() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_todos);
  }

  Future<void> addTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _todos.add(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _todos.removeWhere((todo) => todo.id == id);
  }

  Future<void> toggleTodoStatus(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: !todo.isCompleted,
        dueDate: todo.dueDate,
      );
    }
  }
}
