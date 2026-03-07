import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/size_config.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TodoItem({
    super.key,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueDate,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = dueDate != null &&
        !isCompleted &&
        dueDate!.isBefore(DateTime.now());

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfigs.getProportionateScreenWidth(16),
        vertical: SizeConfigs.getProportionateScreenHeight(8),
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isOverdue
              ? AppColors.colorF14F4A
              : isCompleted
                  ? AppColors.successColor
                  : AppColors.colorE0E0E0,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfigs.getProportionateScreenWidth(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) => onToggle(),
                  activeColor: AppColors.successColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyles.titleTextStyle.copyWith(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: isCompleted
                          ? AppColors.color888E9D
                          : AppColors.primaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: onEdit,
                  color: AppColors.primaryColor,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: onDelete,
                  color: AppColors.colorF14F4A,
                ),
              ],
            ),
            if (description.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfigs.getProportionateScreenWidth(48),
                  right: SizeConfigs.getProportionateScreenWidth(12),
                  bottom: SizeConfigs.getProportionateScreenHeight(8),
                ),
                child: Text(
                  description,
                  style: AppStyles.normalTextStyle.copyWith(
                    color: AppColors.color888E9D,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (dueDate != null)
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfigs.getProportionateScreenWidth(48),
                  right: SizeConfigs.getProportionateScreenWidth(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: isOverdue
                          ? AppColors.colorF14F4A
                          : AppColors.color888E9D,
                    ),
                    SizedBox(width: SizeConfigs.getProportionateScreenWidth(6)),
                    Text(
                      'Due: ${DateFormat('MMM dd, yyyy').format(dueDate!)}',
                      style: AppStyles.normalTextStyle.copyWith(
                        color: isOverdue
                            ? AppColors.colorF14F4A
                            : AppColors.color888E9D,
                        fontSize: 12,
                        fontWeight:
                            isOverdue ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isOverdue) ...[
                      SizedBox(
                          width: SizeConfigs.getProportionateScreenWidth(6)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfigs.getProportionateScreenWidth(8),
                          vertical: SizeConfigs.getProportionateScreenHeight(2),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.colorF14F4A.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'OVERDUE',
                          style: AppStyles.normalTextStyle.copyWith(
                            color: AppColors.colorF14F4A,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
