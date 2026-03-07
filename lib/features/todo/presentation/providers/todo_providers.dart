import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/todo_local_data_source.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_all_todos_usecase.dart';
import '../../domain/usecases/toggle_todo_status_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import 'todo_notifier.dart';
import 'todo_state.dart';

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>((ref) {
  return TodoLocalDataSource();
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final localDataSource = ref.watch(todoLocalDataSourceProvider);
  return TodoRepositoryImpl(localDataSource: localDataSource);
});

final getAllTodosUseCaseProvider = Provider<GetAllTodosUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetAllTodosUseCase(repository);
});

final addTodoUseCaseProvider = Provider<AddTodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return AddTodoUseCase(repository);
});

final updateTodoUseCaseProvider = Provider<UpdateTodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return UpdateTodoUseCase(repository);
});

final deleteTodoUseCaseProvider = Provider<DeleteTodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return DeleteTodoUseCase(repository);
});

final toggleTodoStatusUseCaseProvider = Provider<ToggleTodoStatusUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return ToggleTodoStatusUseCase(repository);
});

final todoProvider = StateNotifierProvider<TodoNotifier, TodoState>((ref) {
  return TodoNotifier(
    getAllTodosUseCase: ref.watch(getAllTodosUseCaseProvider),
    addTodoUseCase: ref.watch(addTodoUseCaseProvider),
    updateTodoUseCase: ref.watch(updateTodoUseCaseProvider),
    deleteTodoUseCase: ref.watch(deleteTodoUseCaseProvider),
    toggleTodoStatusUseCase: ref.watch(toggleTodoStatusUseCaseProvider),
  );
});
