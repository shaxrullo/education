import 'package:education/Model/resultModel.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final QuizSubmitModel result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF18B86A);
    const red = Color(0xFFFF6262);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // TOP BAR
              Row(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      "Test natijasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202938),
                      ),
                    ),
                  ),

                  const SizedBox(width: 46),
                ],
              ),

              const SizedBox(height: 28),

              // TITLE
              const Text(
                "Test yakunlandi! 🎉",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF202938),
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                "Ajoyib ish! Natijangiz bilan tanishing.",
                style: TextStyle(fontSize: 15, color: Color(0xFF7A8495)),
              ),

              const SizedBox(height: 30),

              // SCORE CIRCLE
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: green.withOpacity(.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 205,
                      width: 205,
                      child: CircularProgressIndicator(
                        value: .85,
                        strokeWidth: 12,
                        backgroundColor: const Color(0xFFE8EEF5),
                        valueColor: const AlwaysStoppedAnimation<Color>(green),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3D8),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.emoji_events_rounded,
                            color: Color(0xFFFFB020),
                            size: 34,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          result.percentage.toString(),
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: green,
                          ),
                        ),

                        const Text(
                          "Umumiy natija",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7A8495),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // STATISTICS
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _statItem(
                      icon: Icons.check_circle_outline_rounded,
                      value: result.correctAnswers.toString(),
                      title: "To‘g‘ri",
                      color: green,
                    ),
                    _statItem(
                      icon: Icons.cancel_outlined,
                      value: result.wrongAnswers.toString(),
                      title: "Xato",
                      color: red,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // RESULT DETAILS
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Natijalar tafsiloti",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF202938),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _resultItem(
                      title: "To‘g‘ri javoblar",
                      value:
                          "${result.correctAnswers} / ${result.totalQuestions}",
                          percent: (result.correctAnswers ?? 0) / (result.totalQuestions ?? 1),
                      color: green,
                    ),

                    const SizedBox(height: 22),

                    _resultItem(
                      title: "Xato javoblar",
                      value:
                          "${result.wrongAnswers} / ${result.totalQuestions}",
                      percent:
                          (result.wrongAnswers ?? 0) /
                          (result.totalQuestions ?? 1),
                      color: red,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 150),
              // HOME BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home_rounded, color: green),
                  label: const Text(
                    "Bosh sahifaga qaytish",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: green,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: green, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // STAT ITEM
  Widget _statItem({
    required IconData icon,
    required String value,
    required String title,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 29),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Color(0xFF7A8495)),
          ),
        ],
      ),
    );
  }

  // RESULT ITEM
  Widget _resultItem({
    required String title,
    required String value,
    required double percent,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A5568),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 9,
            backgroundColor: const Color(0xFFE9EEF5),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
