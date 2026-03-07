import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../domain/entities/todo_entity.dart';
import '../providers/todo_providers.dart';
import '../widgets/add_edit_todo_dialog.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/todo_item.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    SizeConfigs.init(context);
    
    final todoState = ref.watch(todoProvider);
    final filteredTodos = _getFilteredTodos(todoState.todos);
    final completedCount = todoState.completedTodos.length;
    final pendingCount = todoState.pendingTodos.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo APP'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(todoProvider.notifier).loadTodos();
            },
          ),
        ],
      ),
      body: todoState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : todoState.errorMessage != null
              ? _buildErrorState(todoState.errorMessage!)
              : Column(
                  children: [
                    _buildFilterChips(pendingCount, completedCount),

                    Expanded(
                      child: filteredTodos.isEmpty
                          ? _buildEmptyState()
                          : _buildTodoList(filteredTodos),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTodoDialog,
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: Text(
          'Add Todo',
          style: AppStyles.normalTextStyle.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(int pendingCount, int completedCount) {
    final todoState = ref.watch(todoProvider);
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfigs.getProportionateScreenWidth(16),
        vertical: SizeConfigs.getProportionateScreenHeight(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChipButton(
              label: 'All',
              count: todoState.todos.length,
              isSelected: _selectedFilter == 'All',
              onTap: () {
                setState(() {
                  _selectedFilter = 'All';
                });
              },
            ),
            SizedBox(width: SizeConfigs.getProportionateScreenWidth(8)),
            FilterChipButton(
              label: 'Pending',
              count: pendingCount,
              isSelected: _selectedFilter == 'Pending',
              onTap: () {
                setState(() {
                  _selectedFilter = 'Pending';
                });
              },
            ),
            SizedBox(width: SizeConfigs.getProportionateScreenWidth(8)),
            FilterChipButton(
              label: 'Completed',
              count: completedCount,
              isSelected: _selectedFilter == 'Completed',
              onTap: () {
                setState(() {
                  _selectedFilter = 'Completed';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList(List<TodoEntity> todos) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: SizeConfigs.getProportionateScreenHeight(8),
        bottom: SizeConfigs.getProportionateScreenHeight(80),
      ),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          title: todo.title,
          description: todo.description,
          isCompleted: todo.isCompleted,
          dueDate: todo.dueDate,
          onToggle: () {
            ref.read(todoProvider.notifier).toggleTodoStatus(todo.id);
          },
          onDelete: () {
            _showDeleteConfirmation(todo.id);
          },
          onEdit: () {
            _showEditTodoDialog(todo);
          },
        );
      },
    );
  }

  List<TodoEntity> _getFilteredTodos(List<TodoEntity> todos) {
    switch (_selectedFilter) {
      case 'Completed':
        return todos.where((todo) => todo.isCompleted).toList();
      case 'Pending':
        return todos.where((todo) => !todo.isCompleted).toList();
      default:
        return todos;
    }
  }


  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: AppColors.colorF14F4A.withOpacity(0.5),
          ),
          SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),
          Text(
            'Error: $message',
            style: AppStyles.titleTextStyle.copyWith(
              color: AppColors.colorF14F4A,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),
          ElevatedButton(
            onPressed: () {
              ref.read(todoProvider.notifier).loadTodos();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 80,
            color: AppColors.color888E9D.withOpacity(0.5),
          ),
          SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),
          Text(
            _selectedFilter == 'All'
                ? 'No todos yet. Add one to get started!'
                : 'No $_selectedFilter todos.',
            style: AppStyles.titleTextStyle.copyWith(
              color: AppColors.color888E9D,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddTodoDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddEditTodoDialog(),
    );

    if (result != null && mounted) {
      await ref.read(todoProvider.notifier).addTodo(
            title: result['title'],
            description: result['description'],
            dueDate: result['dueDate'],
          );
      
      if (mounted) {
        SnackbarUtils.showSuccess(context, 'Todo added successfully!');
      }
    }
  }

  void _showEditTodoDialog(TodoEntity todo) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddEditTodoDialog(
        todo: {
          'id': todo.id,
          'title': todo.title,
          'description': todo.description,
          'dueDate': todo.dueDate,
        },
      ),
    );

    if (result != null && mounted) {
      final updatedTodo = todo.copyWith(
        title: result['title'],
        description: result['description'],
        dueDate: result['dueDate'],
      );
      
      await ref.read(todoProvider.notifier).updateTodo(updatedTodo);
      
      if (mounted) {
        SnackbarUtils.showSuccess(context, 'Todo updated successfully!');
      }
    }
  }

  Future<void> _showDeleteConfirmation(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Todo',
          style: AppStyles.headingTextStyle.copyWith(fontSize: 18),
        ),
        content: Text(
          'Are you sure you want to delete this todo?',
          style: AppStyles.normalTextStyle.copyWith(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: AppStyles.normalTextStyle.copyWith(
                color: AppColors.color888E9D,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: AppStyles.normalTextStyle.copyWith(
                color: AppColors.colorF14F4A,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(todoProvider.notifier).deleteTodo(id);
      
      if (mounted) {
        SnackbarUtils.showError(context, 'Todo deleted successfully!');
      }
    }
  }
}
