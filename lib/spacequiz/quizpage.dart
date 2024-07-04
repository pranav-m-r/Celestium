import 'package:flutter/material.dart';

import '../data/globals.dart';
import 'quizdata.dart';

String quizTopic = 'Our Universe - I';

class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final controller = PageController();

  int qno = 1;
  int score = 0;
  int qtracker = 0;
  bool isLocked = false;

  final qd = QuizData();

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    questions = qd.quizData[quizTopic];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    SizedBox dspacing() {
      return SizedBox(height: padding * 0.8 * 2);
    }

    Column buildQuestion(Question question) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacing(),
          Text(
            question.text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          spacing(),
          Expanded(
            child: OptionsWidget(
              question: question,
              onClickedOption: (option) {
                if (!question.isLocked) {
                  setState(() {
                    question.selectedOption = option;
                    qtracker++;
                    question.isLocked = true;
                  });
                  isLocked = question.isLocked;
                  if (question.selectedOption!.isCorrect) {
                    score++;
                  }
                }
              },
            ),
          ),
        ],
      );
    }

    SizedBox nextButton() {
      double y = 0.09;
      return SizedBox(
        height: screenHeight * y,
        width: screenWidth * 0.8,
        child: ElevatedButton(
          style: btnStyle,
          onPressed: () {
            if (qno < questions.length) {
              controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
              );
              setState(() {
                qno++;
                isLocked = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                (qno < questions.length)
                    ? 'Next Question'
                    : 'Score: $score out of ${questions.length}',
                style: const TextStyle(fontSize: 25),
              ),
              (qno < questions.length)
                  ? const Icon(Icons.arrow_forward_ios_rounded, size: 24)
                  : const Icon(Icons.exit_to_app, size: 28),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(quizTopic),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              dspacing(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding * 0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (qtracker != 0) ? "Score: $score/$qtracker" : "",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      "Question $qno/${questions.length}",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Divider(color: txtColor, thickness: 1),
              Expanded(
                  child: PageView.builder(
                itemCount: questions.length,
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return buildQuestion(question);
                },
              )),
              isLocked ? spacing() : const SizedBox.shrink(),
              isLocked ? nextButton() : const SizedBox.shrink(),
              isLocked ? dspacing() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget(
      {Key? key, required this.question, required this.onClickedOption})
      : super(key: key);

  Color getColorForOption(Option option, Question question) {
    final isSelected = (option == question.selectedOption);
    if (isSelected) {
      return option.isCorrect ? Colors.green : Colors.red;
    } else if (option.isCorrect && question.isLocked) {
      return Colors.green;
    }
    return txtColor;
  }

  Widget getIconForOption(Option option, Question question) {
    final isSelected = (option == question.selectedOption);
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.cancel, color: Colors.red);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth * 0.05;

    Padding buildOption(BuildContext context, Option option) {
      final color = getColorForOption(option, question);
      return Padding(
        padding: EdgeInsets.symmetric(vertical: padding * 0.3),
        child: GestureDetector(
          onTap: () => onClickedOption(option),
          child: Material(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: ListTile(
              title: Text(
                option.text,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              trailing: getIconForOption(option, question),
              textColor: Colors.white,
              tileColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: color, width: 1),
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: question.options.map((option) {
          return buildOption(context, option);
        }).toList(),
      ),
    );
  }
}
