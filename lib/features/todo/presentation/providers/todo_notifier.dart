import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_all_todos_usecase.dart';
import '../../domain/usecases/toggle_todo_status_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import 'todo_state.dart';

class TodoNotifier extends StateNotifier<TodoState> {
  final GetAllTodosUseCase getAllTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final ToggleTodoStatusUseCase toggleTodoStatusUseCase;

  TodoNotifier({
    required this.getAllTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.toggleTodoStatusUseCase,
  }) : super(TodoState.initial()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    try {
      state = state.setLoading();
      final todos = await getAllTodosUseCase();
      state = state.setSuccess(todos);
    } catch (e) {
      state = state.setError(e.toString());
    }
  }

  Future<void> addTodo({
    required String title,
    required String description,
    DateTime? dueDate,
  }) async {
    try {
      final newTodo = TodoEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        isCompleted: false,
        dueDate: dueDate,
      );

      await addTodoUseCase(newTodo);
      await loadTodos();
    } catch (e) {
      state = state.setError(e.toString());
    }
  }

  Future<void> updateTodo(TodoEntity todo) async {
    try {
      await updateTodoUseCase(todo);
      await loadTodos();
    } catch (e) {
      state = state.setError(e.toString());
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await deleteTodoUseCase(id);
      await loadTodos();
    } catch (e) {
      state = state.setError(e.toString());
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      await toggleTodoStatusUseCase(id);
      await loadTodos();
    } catch (e) {
      state = state.setError(e.toString());
    }
  }
}
