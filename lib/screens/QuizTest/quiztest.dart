import 'package:education/Bloc/quizList/bloc/quizlist_bloc.dart';
import 'package:education/screens/QuizTest/quizlists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Quiztest extends StatefulWidget {
  final int courseId;
  final String title;
  Quiztest({super.key, required this.courseId, required this.title});

  @override
  State<Quiztest> createState() => _QuiztestState();
}

class _QuiztestState extends State<Quiztest> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<QuizlistBloc>().add(QuizRequested(courseId: widget.courseId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title}")),
      body: BlocBuilder<QuizlistBloc, QuizlistState>(
        builder: (context, state) {
          if (state is QuizlistFailure) {
            return Text(state.message);
          }
          if (state is QuizlistLoaded) {
            return GridView.builder(
              itemCount: state.quizes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final quiz = state.quizes[index];
                return Card(
                  child: Container(
                    padding: .all(12.r),
                    margin: .symmetric(horizontal: 5.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text("${quiz.title}"),
                        SizedBox(height: 4.h),
                        Text("${quiz.passingScore} o'tish scorei"),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.format_list_bulleted_outlined),
                            Text(" ${quiz.questionCount} ta"),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(
                                questions: quiz.questions,
                                quizId: quiz.id,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40.h),
                            backgroundColor: const Color.fromARGB(
                              255,
                              38,
                              124,
                              40,
                            ),
                          ),
                          label: Text("Start"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
