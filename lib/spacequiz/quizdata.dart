import 'quizpage.dart';

class QuizData {
  late Map quizData;

  Question question(
      String q, String op1, String op2, String op3, String op4, int correct) {
    List<Option> options = [
      Option(text: op1, isCorrect: (correct == 1) ? true : false),
      Option(text: op2, isCorrect: (correct == 2) ? true : false),
      Option(text: op3, isCorrect: (correct == 3) ? true : false),
      Option(text: op4, isCorrect: (correct == 4) ? true : false),
    ];
    options.shuffle();
    return Question(
      text: q,
      options: options,
    );
  }

  QuizData() {
    quizData = {
      "Our Universe - I": [
        question('What is the capital of India?', 'Mumbai', 'Delhi', 'Kolkata',
            'Chennai', 2),
        question('What is the capital of France?', 'Mumbai', 'Mumbai', 'Mumbai',
            'Mumbai', 3),
        question('What is the capital of Japan?', 'Mumbai', 'Tokyo', 'Kolkata',
            'Chennai', 2),
        question('What is the capital of Australia?', 'Canberra', 'Delhi',
            'Kolkata', 'Chennai', 1),
      ],
    };
  }
}
