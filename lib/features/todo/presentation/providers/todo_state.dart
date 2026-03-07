import '../../domain/entities/todo_entity.dart';

class TodoState {
  final List<TodoEntity> todos;
  final bool isLoading;
  final String? errorMessage;

  const TodoState({
    this.todos = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TodoState copyWith({
    List<TodoEntity>? todos,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory TodoState.initial() {
    return const TodoState();
  }

  TodoState setLoading() {
    return copyWith(isLoading: true, errorMessage: null);
  }

  TodoState setSuccess(List<TodoEntity> todos) {
    return copyWith(
      todos: todos,
      isLoading: false,
      errorMessage: null,
    );
  }

  TodoState setError(String message) {
    return copyWith(
      isLoading: false,
      errorMessage: message,
    );
  }

  List<TodoEntity> get completedTodos {
    return todos.where((todo) => todo.isCompleted).toList();
  }

  List<TodoEntity> get pendingTodos {
    return todos.where((todo) => !todo.isCompleted).toList();
  }

  List<TodoEntity> get overdueTodos {
    return todos.where((todo) => todo.isOverdue).toList();
  }
}
