import 'package:flutter/material.dart';
import '../../domain/entities/task_step.dart';

class TaskStepCard extends StatelessWidget {
  final TaskStep step;
  final ValueChanged<TaskStep> onToggle;

  const TaskStepCard({super.key, required this.step, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onToggle(step),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: step.isCompleted,
                onChanged: (_) => onToggle(step),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step ${step.position}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: step.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: step.isCompleted ? Colors.grey : null,
                      ),
                    ),
                    if (step.description != null &&
                        step.description!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        step.description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
