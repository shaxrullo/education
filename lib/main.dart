import 'package:education/Bloc/Category/category_bloc.dart';
import 'package:education/Bloc/Complete/bloc/complete_bloc.dart';
import 'package:education/Bloc/CourseProgress/bloc/courseprogress_bloc.dart';
import 'package:education/Bloc/Courses/courses_bloc.dart';
import 'package:education/Bloc/Lesson/bloc/lesson_bloc.dart';
import 'package:education/Bloc/LessonDetail/lesson_detail_bloc.dart';
import 'package:education/Bloc/Login/login_bloc.dart';
import 'package:education/Bloc/Progress/progress_bloc.dart';
import 'package:education/Bloc/Register/register_bloc.dart';
import 'package:education/Bloc/quizList/bloc/quizlist_bloc.dart';
import 'package:education/Bloc/submit/bloc/submit_bloc.dart';
import 'package:education/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => RegisterBloc()),
            BlocProvider(create: (_) => LoginBloc()),
            BlocProvider(create: (_) => CategoryBloc()),
            BlocProvider(create: (_) => CoursesBloc()),
            BlocProvider(create: (_) => CompleteBloc()),
            BlocProvider(create: (_) => LessonBloc()),
            BlocProvider(create: (_) => LessonDetailBloc()),
            BlocProvider(create: (_) => QuizlistBloc()),
            BlocProvider(create: (_) => ProgressBloc()),
            BlocProvider(create: (_) => SubmitBloc()),
            BlocProvider(create: (_) => CourseprogressBloc()),
          ],
          child: const AppRoot(),
        );
      },
    );
  }
}

/*
cd /home/shaxrullo/Downloads/flutter_project/education_python
source edu_platform_env/bin/activate
python manage.py runserver 0.0.0.0:8000
*/