import 'dart:async';

import 'package:education/Bloc/Complete/bloc/complete_bloc.dart';
import 'package:education/Bloc/Lesson/bloc/lesson_bloc.dart';
import 'package:education/Bloc/LessonDetail/lesson_detail_bloc.dart';
import 'package:education/Bloc/Progress/progress_bloc.dart';
import 'package:education/Model/completeModel.dart';
import 'package:education/Model/lessonModel.dart';
import 'package:education/app/theme/app_colors.dart';
import 'package:education/app/theme/app_text_styles.dart';
import 'package:education/widgets/custom_app_bar.dart';
import 'package:education/widgets/lesson_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonScreen extends StatefulWidget {
  final bool isComplete;
  final LessonModel lesson;
  final String courseTitle;
  final int courseId;

  const LessonScreen({
    super.key,
    required this.lesson,
    required this.courseTitle,
    required this.isComplete,
    required this.courseId
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool _isPlaying = false;

  YoutubePlayerController? _controller;

  Timer? _timer;

  Duration _currentPosition = Duration.zero;

  String extractYoutubeId(String url) {
    final regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:e(?:mbed)?)\/|(?:\?v=|\&v=))([\w-]{11})',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  @override
  void dispose() {
    _stopTimer();
    _controller!.close();
    super.dispose();
  }

  Future<void> _sendProgress() async {
    // 1. Joriy vaqt va umumiy vaqtni olish (Future bo'lgani uchun await ishlatiladi)
    final double currentDouble = await _controller!.currentTime;
    final double totalDouble = await _controller!.duration;

    // 2. double ni int (sekund) ga o'tkazish
    final int currentSeconds = currentDouble.toInt();
    final int totalDuration = totalDouble.toInt();

    // 3. Frontend guard (xavfsizlik cheklovi)
    final int safeWatchedSeconds =
        (totalDuration > 0 && currentSeconds > totalDuration)
        ? totalDuration
        : currentSeconds;

    // BLoC ga yuborish
    if (mounted) {
      context.read<ProgressBloc>().add(
        ProgressRequested(
          lessonId: widget.lesson.id!,
          secondsWatched: safeWatchedSeconds,
        ),
      );
      if (totalDuration > 0 && currentSeconds >= totalDuration - 2) {
        context.read<CompleteBloc>().add(
          CompleteRequest(lessonId: widget.lesson.id!),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final rawUrl = widget.lesson.videoUrl ?? '';
    String videoId;
    if (rawUrl.isEmpty || rawUrl.contains('demo')) {
      videoId = 'L_LUpnjgPso';
    } else {
      videoId = extractYoutubeId(rawUrl);
    }

    print('YOUTUBE VIDEO ID: $videoId');
    print("Shaxrullo${widget.lesson.videoUrl}Shaxrullo Shaxrullo");
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: false,
        showFullscreenButton: false,
        mute: false,
      ),
    );

    _controller!.stream.listen((event) {
      if (mounted) {
        final playing = event.playerState == PlayerState.playing;
        setState(() {
          _isPlaying = playing;
        });

        if (playing) {
          _startTimer();
        } else {
          _stopTimer();
        }
      }
    });

    context.read<LessonDetailBloc>().add(
      LessonDetailsRequested(lessonId: widget.lesson.id!),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      final double currentTimeInSeconds = await _controller!.currentTime;
      if (mounted) {
        setState(() {
          _currentPosition = Duration(seconds: currentTimeInSeconds.toInt());
        });
      }
      if (_currentPosition.inSeconds > 0 &&
          _currentPosition.inSeconds % 10 == 0) {
        _sendProgress();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _sendProgress();
  }

  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: widget.courseTitle,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              Icons.more_vert_rounded,
              color: AppColors.textPrimary,
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player placeholder
            _buildVideoPlayer(lesson.videoUrl),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator
                  _buildProgressBar(),
                  SizedBox(height: 16.h),
                  // Lesson title & info
                  Text(lesson.title, style: AppTextStyles.h3),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: AppColors.gray400,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        lesson.duration.toString(),
                        style: AppTextStyles.caption,
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.play_circle_outline_rounded,
                        size: 14.sp,
                        color: AppColors.gray400,
                      ),
                      SizedBox(width: 4.w),
                      Text('Video Lesson', style: AppTextStyles.caption),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Navigation buttons
                  _buildNavButtons(context, widget.lesson.id!),
                  SizedBox(height: 20.h),
                  const Divider(color: AppColors.divider),
                  SizedBox(height: 16.h),
                  // Description
                  if (lesson.description != null) ...[
                    Text('Lesson Description', style: AppTextStyles.h4),
                    SizedBox(height: 10.h),
                    Text(
                      lesson.description!,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],

                  // Lesson list from same course
                  Text('All Lessons', style: AppTextStyles.h4),
                  SizedBox(height: 12.h),
                  BlocBuilder<CompleteBloc, CompleteState>(
                    builder: (context, completeState) {
                      // completion map
                      final Map<int, bool> completionMap = {};
                      if (completeState is CompleteLoaded) {
                        for (var c in completeState.complete) {
                          completionMap[c.lesson] = c.isCompleted;
                        }
                      }

                      return BlocBuilder<LessonBloc, LessonState>(
                        builder: (context, lessonState) {
                          if (lessonState is LessonLoading)
                            return CircularProgressIndicator();
                          if (lessonState is LessonFailure)
                            return Text(lessonState.message);
                          if (lessonState is LessonLoaded) {
                            final lessons = lessonState.lessons;
                            return Column(
                              children: lessons.asMap().entries.map((e) {
                                final lesson = e.value;
                                final isCompleted =
                                    completionMap[lesson.id] ?? false;
                                return LessonTile(
                                  lesson: lesson,
                                  index: e.key + 1,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LessonScreen(
                                        lesson: lesson,
                                        courseTitle: widget.courseTitle,
                                        isComplete: isCompleted,
                                        courseId: widget.courseId,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const SizedBox();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(String videoUrl) {
    return GestureDetector(
      onTap: () {
        if (_isPlaying) {
          _controller?.pauseVideo();
        } else {
          _controller?.playVideo();
        }
      },
      child: Container(
        width: double.infinity,
        height: 220.h,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1B4B), Color(0xFF3730A3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // 1. YouTube Video Vidjeti
            Positioned.fill(
              child: YoutubePlayer(
                controller: _controller!,
                aspectRatio: 16 / 9,
              ),
            ),

            // 2. Play/Pause overlay
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isPlaying ? 0.0 : 1.0,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 64.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 36.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      _isPlaying ? 'Playing...' : 'Tap to play',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Pastki boshqaruv paneli (Control bar)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: StreamBuilder<YoutubePlayerValue>(
                  stream: _controller!.stream,
                  builder: (context, snapshot) {
                    final value = snapshot.data;
                    final duration = value?.metaData.duration ?? Duration.zero;

                    // Progress foizini hisoblash
                    double progress = 0.0;
                    if (duration.inMilliseconds > 0) {
                      progress =
                          _currentPosition.inMilliseconds /
                          duration.inMilliseconds;
                    }

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_isPlaying) {
                              _controller!.pauseVideo();
                            } else {
                              _controller!.playVideo();
                            }
                          },
                          child: Icon(
                            _isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2.r),
                            child: LinearProgressIndicator(
                              value: progress.clamp(0.0, 1.0),
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.3,
                              ),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              minHeight: 3.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Aniq vaqt va umumiy vaqt ko'rinishi
                        Text(
                          '${_formatDuration(_currentPosition)} / ${_formatDuration(duration)}',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () => _controller!.toggleFullScreen(),
                          child: Icon(
                            Icons.fullscreen_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Widget _buildProgressBar() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Course Progress', style: AppTextStyles.bodySmSemi),
              const Spacer(),
              Text(
                '3/5 lessons',
                style: AppTextStyles.caption.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: AppColors.gray100,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              minHeight: 7.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButtons(BuildContext context, int id) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<CompleteBloc, CompleteState>(
            builder: (context, completeState) {
              print("CompleteBloc state: ${completeState}");
              if (completeState is CompleteFailure) {
                return Text(completeState.message);
              }
              if (completeState is! CompleteLoaded) {
                return const SizedBox();
              }

              return BlocBuilder<LessonBloc, LessonState>(
                builder: (context, lessonState) {
                  if (lessonState is LessonFailure) {
                    return Center(child: Text(lessonState.message));
                  }
                  if (lessonState is! LessonLoaded) {
                    return const SizedBox();
                  }

                  final lessons = lessonState.lessons;
                  // 1-tuzatish: "id--" emas, joriy darsning ro'yxatdagi ORNI topiladi
                  final currentIndex = lessons.indexWhere(
                    (l) => l.id == widget.lesson.id,
                  );

                  return OutlinedButton.icon(
                    onPressed: () {
                      if (currentIndex <= 0) {
                        // 2-tuzatish: to'g'ri SnackBar chaqiruvi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Siz allaqachon birinchi darsdasiz :)",
                            ),
                          ),
                        );
                        return;
                      }

                      final previousLesson = lessons[currentIndex - 1];

                      // 3-tuzatish: shu darsning completion holatini completionMap orqali topamiz
                      final isCompleted = completeState.complete
                          .firstWhere(
                            (c) => c.lesson == previousLesson.id,
                            orElse: () => Completemodel(
                              id: 0,
                              lesson: previousLesson.id!,
                              lessonTitle: previousLesson.title,
                              isCompleted: false,
                              completedAt: null,
                              watchedSeconds: 0,
                            ),
                          )
                          .isCompleted;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonScreen(
                            lesson: previousLesson,
                            courseTitle: widget.courseTitle,
                            isComplete: isCompleted,
                            courseId: widget.courseId,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16.sp,
                      color: AppColors.textPrimary,
                    ),
                    label: Text(
                      'Previous',
                      style: AppTextStyles.bodyMdSemi.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: BlocBuilder<CompleteBloc, CompleteState>(
            builder: (context, completeState) {
              print("CompleteBloc state: ${completeState}");
              if (completeState is CompleteFailure) {
                return Text(completeState.message);
              }
              if (completeState is! CompleteLoaded) {
                return const SizedBox();
              }

              return BlocBuilder<LessonBloc, LessonState>(
                builder: (context, lessonState) {
                  if (lessonState is LessonFailure) {
                    return Center(child: Text(lessonState.message));
                  }
                  if (lessonState is! LessonLoaded) {
                    return const SizedBox();
                  }

                  final lessons = lessonState.lessons;
                  final currentIndex = lessons.indexWhere(
                    (l) => l.id == widget.lesson.id,
                  );

                  return ElevatedButton.icon(
                    onPressed: () {
                      if (currentIndex == -1 ||
                          currentIndex + 1 >= lessons.length) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Siz allaqachon oxirgi darsdasiz :)"),
                          ),
                        );
                        return;
                      }

                      final previousLesson = lessons[currentIndex + 1];

                      final isCompleted = completeState.complete
                          .firstWhere(
                            (c) => c.lesson == previousLesson.id,
                            orElse: () => Completemodel(
                              id: 0,
                              lesson: previousLesson.id!,
                              lessonTitle: previousLesson.title,
                              isCompleted: false,
                              completedAt: null,
                              watchedSeconds: 0,
                            ),
                          )
                          .isCompleted;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonScreen(
                            lesson: previousLesson,
                            courseTitle: widget.courseTitle,
                            isComplete: isCompleted,
                            courseId: widget.courseId,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    label: Text('Next', style: AppTextStyles.button),
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/*ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            label: Text('Next', style: AppTextStyles.button),
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: Colors.white,
            ),
          ),*/
