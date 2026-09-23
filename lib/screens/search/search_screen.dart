// ignore_for_file: must_be_immutable

import 'package:education/Model/CoursesModel.dart' show CourseModel;
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/widgets/empty_error_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  List<CourseModel> coursesList = [];
  SearchScreen({super.key, required this.coursesList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  final List<String> _popularSearches = [
    'Flutter ',
    'Python',
    'Docker',
    'JavaScript',
    'React.js',
  ];

  List<CourseModel> get _results {
    if (_query.isEmpty) return [];
    return widget.coursesList.where((c) {
      return c.title.toLowerCase().contains(_query.toLowerCase()) ||
          c.teacher.name.toLowerCase().contains(_query.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(context),
            Expanded(
              child: _query.isEmpty
                  ? _buildDiscovery()
                  : _buildResults(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 46.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 12.w),
                  Icon(
                    Icons.search_rounded,
                    color: AppColors.gray400,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      onChanged: (v) => setState(() => _query = v),
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search courses, teachers...',
                        hintStyle: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.textHint,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (_query.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _controller.clear();
                        setState(() => _query = '');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.gray400,
                          size: 18.sp,
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

  Widget _buildDiscovery() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          // Popular Searches
          Text('Popular Searches', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _popularSearches
                .map(
                  (s) => GestureDetector(
                    onTap: () {
                      _controller.text = s;
                      setState(() => _query = s);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.trending_up_rounded,
                            size: 14.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            s,
                            style: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    if (_results.isEmpty) {
      return EmptyState(
        emoji: '🔍',
        title: 'No results found',
        subtitle: 'Try different keywords or check spelling',
        buttonLabel: 'Clear Search',
        onButtonTap: () {
          _controller.clear();
          setState(() => _query = '');
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
          child: Text(
            '${_results.length} result${_results.length > 1 ? 's' : ''} for "$_query"',
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: _results.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (_, i) =>
                _SearchResultTile(course: _results[i], onTap: () {}),
          ),
        ),
      ],
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final CourseModel course;
  final VoidCallback onTap;

  const _SearchResultTile({required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(course.image!, height: 60, width: 70, fit: BoxFit.cover,),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: AppTextStyles.bodyMdSemi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(course.teacher.name, style: AppTextStyles.caption),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.stacked_bar_chart_rounded,
                        color: const Color.fromARGB(255, 110, 51, 51),
                        size: 13.sp,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        course.level!,
                        style: AppTextStyles.bodyMd,
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: AppColors.gray300,
            ),
          ],
        ),
      ),
    );
  }
}
