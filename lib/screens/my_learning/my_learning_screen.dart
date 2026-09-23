import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/data/mock_data.dart';
import 'package:education/widgets/empty_error_loading.dart';
import 'package:education/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLearningScreen extends StatefulWidget {
  const MyLearningScreen({super.key});

  @override
  State<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final inProgress = mockEnrollments.where((e) => !e.isCompleted).toList();
  final completed = mockEnrollments.where((e) => e.isCompleted).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildStats(),
            SizedBox(height: 16.h),
            _buildTabBar(),
            SizedBox(height: 16.h),
            Expanded(child: _buildTabContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Learning', style: AppTextStyles.h3),
          SizedBox(height: 4.h),
          Text(
            'Track your learning progress',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _MiniStat(
            icon: Icons.play_circle_outline_rounded,
            value: '${inProgress.length}',
            label: 'In Progress',
            color: AppColors.primary,
          ),
          SizedBox(width: 12.w),
          _MiniStat(
            icon: Icons.check_circle_outline_rounded,
            value: '${completed.length}',
            label: 'Completed',
            color: AppColors.success,
          ),
          SizedBox(width: 12.w),
          _MiniStat(
            icon: Icons.workspace_premium_rounded,
            value: '${mockCertificates.length}',
            label: 'Certificates',
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 46.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(9.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelStyle: AppTextStyles.bodyMdSemi,
          unselectedLabelStyle: AppTextStyles.bodyMd,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('In Progress'),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: _tabController.index == 0
                          ? AppColors.primarySurface
                          : AppColors.gray200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      '${inProgress.length}',
                      style: AppTextStyles.caption.copyWith(
                        color: _tabController.index == 0
                            ? AppColors.primary
                            : AppColors.gray500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Completed'),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: _tabController.index == 1
                          ? AppColors.successLight
                          : AppColors.gray200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      '${completed.length}',
                      style: AppTextStyles.caption.copyWith(
                        color: _tabController.index == 1
                            ? AppColors.success
                            : AppColors.gray500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildList(inProgress, context, false),
        _buildList(completed, context, true),
      ],
    );
  }

  Widget _buildList(
    List<EnrollmentModel> list,
    BuildContext context,
    bool isCompleted,
  ) {
    if (list.isEmpty) {
      return EmptyState(
        emoji: isCompleted ? '🎓' : '📚',
        title: isCompleted ? 'No completed courses' : 'No courses yet',
        subtitle: isCompleted
            ? 'Keep learning to complete your enrolled courses'
            : 'Enroll in a course to start learning',
        buttonLabel: 'Browse Courses',
        onButtonTap: () {},
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: list.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (_, i) => ProgressCard(
        enrollment: list[i],
        onContinue: () {}
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _MiniStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 18.sp),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: AppTextStyles.h4.copyWith(color: color)),
                  Text(
                    label,
                    style: AppTextStyles.caption.copyWith(fontSize: 9.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
