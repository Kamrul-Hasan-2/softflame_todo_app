import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../auth/presentation/widgets/common_button.dart';
import '../../../auth/presentation/widgets/common_text_field.dart';

class AddEditTodoDialog extends StatefulWidget {
  final Map<String, dynamic>? todo;

  const AddEditTodoDialog({super.key, this.todo});

  @override
  State<AddEditTodoDialog> createState() => _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?['title']);
    _descriptionController = TextEditingController(text: widget.todo?['description']);
    _selectedDueDate = widget.todo?['dueDate'];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs.init(context);
    final isEdit = widget.todo != null;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(SizeConfigs.getProportionateScreenWidth(20)),
        constraints: BoxConstraints(
          maxHeight: SizeConfigs.getProportionateScreenHeight(600),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit ? 'Edit Todo' : 'Add New Todo',
                      style: AppStyles.headingTextStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(16)),
                CommonTextField(
                  controller: _titleController,
                  hintText: 'Enter todo title',
                  prefixIcon: const Icon(Icons.title),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),
                CommonTextField(
                  controller: _descriptionController,
                  hintText: 'Enter description',
                  prefixIcon: const Icon(Icons.description),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(12)),
                GestureDetector(
                  onTap: _selectDueDate,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfigs.getProportionateScreenWidth(16),
                      vertical: SizeConfigs.getProportionateScreenHeight(14),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.colorE0E0E0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: AppColors.color888E9D),
                        SizedBox(width: SizeConfigs.getProportionateScreenWidth(12)),
                        Expanded(
                          child: Text(
                            _selectedDueDate != null
                                ? 'Due: ${DateFormat('MMM dd, yyyy').format(_selectedDueDate!)}'
                                : 'Select due date (optional)',
                            style: AppStyles.normalTextStyle.copyWith(
                              color: _selectedDueDate != null
                                  ? AppColors.primaryTextColor
                                  : AppColors.color888E9D,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (_selectedDueDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              setState(() {
                                _selectedDueDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfigs.getProportionateScreenHeight(20)),
                CommonButton(
                  onPressed: _handleSubmit,
                  text: isEdit ? 'Update Todo' : 'Add Todo',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              surface: AppColors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'dueDate': _selectedDueDate,
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
