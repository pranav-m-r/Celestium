import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:astroquest/globals.dart';

class CreateStar extends StatefulWidget {
  const CreateStar({super.key});

  @override
  State<CreateStar> createState() => _CreateStarState();
}

class _CreateStarState extends State<CreateStar> {
  final massController = TextEditingController();
  final lumController = TextEditingController();
  final tempController = TextEditingController();

  void createStar() {
    if (massController.text.isEmpty ||
        lumController.text.isEmpty ||
        tempController.text.isEmpty) {
      showErrorMessage('Please enter all values!', context);
      return;
    }

    double mass = double.parse(massController.text);
    double lum = double.parse(lumController.text);
    double temp = double.parse(tempController.text);

    if (temp < 2000 || temp > 100000) {
      showErrorMessage(
          'Surface temperature must lie between 2000 K and 100000 K', context);
      return;
    }

    if (mass < 0.1 || mass > 100) {
      showErrorMessage(
          'Mass must lie between 0.1 and 100 Solar Masses', context);
      return;
    }

    if (lum < 0.0001 || lum > 1000000) {
      showErrorMessage(
          'Luminosity must lie between 0.0001 and 1000000 Solar Luminosities',
          context);
      return;
    }

    resHead = 'Star Created!';
    resBody = 'Test';
    resImgPath = 'test';
    Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    SizedBox uiButton(void Function() fxn, String txt, Widget icon) {
      double y = 0.09;
      return SizedBox(
        height: screenHeight * y,
        child: ElevatedButton(
          style: style,
          onPressed: fxn,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Text(
                txt,
                style: const TextStyle(fontSize: 25),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 27,
              ),
            ],
          ),
        ),
      );
    }

    Padding textInput(TextEditingController ctr, String hint) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
        child: TextField(
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.left,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade300),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: txtColor, width: 0.8),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: txtColor, width: 1.6),
            ),
            fillColor: Colors.black26,
            filled: true,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      );
    }

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    SizedBox dspacing() {
      return SizedBox(height: padding * 0.8 * 2);
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar('Create Star'),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            text(20, 'Mass (Solar Masses)'),
            spacing(),
            textInput(massController, 'Mass'),
            dspacing(),
            text(20, 'Luminosity (Solar Lum.)'),
            spacing(),
            textInput(lumController, 'Luminosity'),
            dspacing(),
            text(20, 'Surface Temperature (K)'),
            spacing(),
            textInput(tempController, 'Temperature'),
            spacing(),
            dspacing(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: uiButton(createStar, 'Create Star',
                  const Icon(Icons.create, size: 27)),
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}
