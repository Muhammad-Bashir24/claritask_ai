import 'package:claritask_ai/core/utils/custom_toast.dart';
import 'package:claritask_ai/features/personalization/presentation/cubit/personalization_cubit.dart';
import 'package:claritask_ai/features/personalization/presentation/cubit/personalization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PersonalizationPage extends StatelessWidget {
  const PersonalizationPage({super.key});

  void _onContinue(BuildContext context, PersonalizationState state) {
    if (!state.canContinue) {
      CustomToast.show(
        context: context,
        message: 'Please make a selection to continue.',
        type: ToastType.error,
      );
      return;
    }

    if (state.currentStep == 5) {
      context.read<PersonalizationCubit>().submitPersonalization();
    } else {
      context.read<PersonalizationCubit>().nextStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalizationCubit, PersonalizationState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.isSuccess != current.isSuccess,
      listener: (context, state) {
        if (state.errorMessage != null) {
          CustomToast.show(
            context: context,
            message: state.errorMessage!,
            type: ToastType.error,
          );
          context.read<PersonalizationCubit>().resetError();
        }

        if (state.isSuccess) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFC),
          body: SafeArea(
            child: Column(
              children: [
                _buildProgressHeader(state),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: _buildCurrentStep(context, state),
                  ),
                ),
                _buildBottomBar(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressHeader(PersonalizationState state) {
    final progress = state.currentStep / 5;
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${state.currentStep} of 5',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: double.infinity,
              height: 6.h,
              child: Stack(
                children: [
                  Container(color: const Color(0xFFE2E8F0)),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, PersonalizationState state) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (state.currentStep > 1)
            Expanded(
              child: OutlinedButton(
                onPressed: state.isSubmitting
                    ? null
                    : () => context.read<PersonalizationCubit>().previousStep(),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          if (state.currentStep > 1) SizedBox(width: 16.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: state.isSubmitting
                  ? null
                  : () => _onContinue(context, state),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: state.isSubmitting
                  ? SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      state.currentStep == 5 ? 'Finish' : 'Continue',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context, PersonalizationState state) {
    switch (state.currentStep) {
      case 1:
        return _buildStep1(context, state);
      case 2:
        return _buildStep2(context, state);
      case 3:
        return _buildStep3(context, state);
      case 4:
        return _buildStep4(context, state);
      case 5:
        return _buildStep5(context, state);
      default:
        return const SizedBox();
    }
  }

  Widget _buildHeader(String title, [String? subtitle]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF64748B)),
          ),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildOptionCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool isMultiSelect = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F5F9) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0F172A)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF0F172A)
                      : const Color(0xFF334155),
                ),
              ),
            ),
            if (isMultiSelect)
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF0F172A)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFCBD5E1),
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                    : null,
              )
            else
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFCBD5E1),
                    width: isSelected ? 7 : 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1(BuildContext context, PersonalizationState state) {
    final options = {
      'personal_tasks': 'Personal tasks',
      'school_study': 'School / study tasks',
      'work_professional': 'Work / professional tasks',
      'business_startup': 'Business / startup tasks',
      'tech_coding': 'Tech / coding tasks',
      'cooking_home': 'Cooking & home tasks',
      'creative_content': 'Creative / content tasks',
      'learning_skills': 'Learning new skills',
      'health_fitness': 'Health / fitness tasks',
      'other': 'Other',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('What do you mostly use ClariTask AI for?'),
        ...options.entries.map(
          (e) => _buildOptionCard(
            title: e.value,
            isSelected: state.primaryUsage == e.key,
            onTap: () =>
                context.read<PersonalizationCubit>().selectPrimaryUsage(e.key),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2(BuildContext context, PersonalizationState state) {
    final options = {
      'student': 'Student',
      'entrepreneur': 'Entrepreneur',
      'creator_influencer': 'Creator / Influencer',
      'developer_tech_worker': 'Developer / tech worker',
      'professional_employee': 'Professional / employee',
      'freelancer': 'Freelancer',
      'homemaker': 'Homemaker',
      'self_improvement': 'Self-improvement / personal growth',
      'other': 'Other',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('What best describes you?', 'Select all that apply'),
        ...options.entries.map(
          (e) => _buildOptionCard(
            title: e.value,
            isSelected: state.userTypes.contains(e.key),
            isMultiSelect: true,
            onTap: () =>
                context.read<PersonalizationCubit>().toggleUserType(e.key),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(BuildContext context, PersonalizationState state) {
    final options = {
      'dont_know_where_to_start': "I don't know where to start",
      'tasks_feel_overwhelming': 'Tasks feel overwhelming',
      'need_task_broken_into_steps': 'I need a single thing broken into steps',
      'want_more_consistency': 'I want to be more consistent',
      'need_more_structure': 'I need more structure',
      'want_faster_execution': 'I want faster execution',
      'need_help_learning': 'I need help learning how to do things',
      'other': 'Other',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('What is your biggest challenge when handling tasks?'),
        ...options.entries.map(
          (e) => _buildOptionCard(
            title: e.value,
            isSelected: state.biggestChallenge == e.key,
            onTap: () => context
                .read<PersonalizationCubit>()
                .selectBiggestChallenge(e.key),
          ),
        ),
      ],
    );
  }

  Widget _buildStep4(BuildContext context, PersonalizationState state) {
    final options = {
      'daily': 'Daily',
      'few_times_per_week': 'A few times per week',
      'weekly': 'Weekly',
      'monthly': 'Monthly',
      'occasionally': 'Occasionally',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('How often do you take on tasks?'),
        ...options.entries.map(
          (e) => _buildOptionCard(
            title: e.value,
            isSelected: state.taskFrequency == e.key,
            onTap: () =>
                context.read<PersonalizationCubit>().selectTaskFrequency(e.key),
          ),
        ),
      ],
    );
  }

  Widget _buildStep5(BuildContext context, PersonalizationState state) {
    final options = {
      'cooking_recipes': 'Cooking / recipes',
      'studying_assignments': 'Studying / assignments',
      'coding_development': 'Coding & development',
      'work_tasks': 'Work tasks',
      'business_planning': 'Business planning',
      'creative_projects': 'Creative projects',
      'personal_organization': 'Personal organization',
      'fitness_health': 'Fitness / health',
      'chores_home': 'Chores & home tasks',
      'event_planning': 'Event planning',
      'learning_skills': 'Learning new skills',
      'other': 'Something else',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          'What types of tasks do you work with right now?',
          'Select all that apply',
        ),
        ...options.entries.map(
          (e) => _buildOptionCard(
            title: e.value,
            isSelected: state.taskTypes.contains(e.key),
            isMultiSelect: true,
            onTap: () =>
                context.read<PersonalizationCubit>().toggleTaskType(e.key),
          ),
        ),
      ],
    );
  }
}
