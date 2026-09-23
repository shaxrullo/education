import 'package:education/Bloc/submit/bloc/submit_bloc.dart';
import 'package:education/Model/quizModel.dart';
import 'package:education/Model/resultModel.dart';
import 'package:education/screens/QuizTest/resultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatefulWidget {
  final List<QuestionModel> questions;
  final int quizId;
  const QuizScreen({super.key, required this.questions, required this.quizId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const _labels = ['A', 'B', 'C', 'D'];
  static const _blue = Color(0xFF4A9FF5);
  static const _pink = Color(0xFFFF6B9D);

  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;

  // Har bir savol uchun tanlangan javob shu yerda saqlanadi
  final List<AnswerRequest> _selectedAnswers = [];

  QuestionModel get _currentQuestion => widget.questions[_currentQuestionIndex];
  bool get _isLastQuestion =>
      _currentQuestionIndex == widget.questions.length - 1;

  void _selectOption(int optionIndex) {
    setState(() => _selectedOptionIndex = optionIndex);
  }

  void _goToNextQuestion() {
    if (_selectedOptionIndex == null) return;

    // 1-tuzatish: javob shu yerda, tugma bosilganda, ro'yxatga qo'shiladi -
    // avval tanlanmasdan submit qilinayotgan edi
    final selectedOption = _currentQuestion.options[_selectedOptionIndex!];
    _selectedAnswers.removeWhere(
      (a) => a.questionId == _currentQuestion.id,
    );
    _selectedAnswers.add(
      AnswerRequest(questionId: _currentQuestion.id, optionId: selectedOption.id),
    );

    if (_isLastQuestion) {
      // Oxirgi savol - endi submit qilinadi
      context.read<SubmitBloc>().add(
        SubmitRequested(quizId: widget.quizId, answers: _selectedAnswers),
      );
    } else {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Quiz',
          style: TextStyle(color: _blue, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: _blue),
      ),
      // 2-tuzatish: submit natijasi faqat BITTA joyda, tashqi BlocConsumer bilan
      // kuzatiladi - har bir variant emas
      body: BlocConsumer<SubmitBloc, SubmitState>(
        listener: (context, state) {
          if (state is SubmitLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ResultScreen(result: state.result),
              ),
            );
          } else if (state is SubmitFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isSubmitting = state is SubmitLoading;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 3-tuzatish: savol matni endi widget.questions'dan,
                // hech qanday bloc kerak emas
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${_currentQuestionIndex + 1}/${widget.questions.length}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _currentQuestion.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 4-tuzatish: variant bosilganda faqat TANLANADI, submit qilinmaydi
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: _currentQuestion.options.length,
                    itemBuilder: (context, i) {
                      final isSelected = _selectedOptionIndex == i;
                      final option = _currentQuestion.options[i];
                      return GestureDetector(
                        onTap: isSubmitting ? null : () => _selectOption(i),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? _blue : _pink,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            // 5-tuzatish: "state" emas, haqiqiy variant matni
                            '${_labels[i]}. ${option.text}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: (_selectedOptionIndex == null || isSubmitting)
                      ? null
                      : _goToNextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          _isLastQuestion ? 'Submit' : 'Next',
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}