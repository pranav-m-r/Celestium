String resHead = 'Result';
String resBody = 'test';
String resImgPath = 'assets/portrait.jpg';

String format(double num) {
  String returnNum = num.toString();
  if (num > 1e6) {
    returnNum = num.toStringAsExponential(2);
  } else if (num < 1e-5) {
    returnNum = num.toStringAsExponential(2);
  } else if (returnNum.contains('.') &&
      num > 1 &&
      returnNum.substring(returnNum.indexOf('.'), returnNum.length).length >
          4) {
    returnNum = returnNum.substring(0, returnNum.indexOf('.') + 3);
  } else if (returnNum.contains('.') &&
      returnNum.substring(returnNum.indexOf('.'), returnNum.length).length >
          6) {
    returnNum = num.toStringAsFixed(5);
  } else if (num % 1 == 0) {
    returnNum = num.toStringAsFixed(0);
  }
  if (returnNum.contains('e+')) {
    returnNum = returnNum.replaceAll('e+', ' x 10^');
  } else if (returnNum.contains('e-')) {
    returnNum = returnNum.replaceAll('e-', ' x 10^-');
  } else if (returnNum.contains('e')) {
    returnNum = returnNum.replaceAll('e', ' x 10^');
  }
  return returnNum;
}
