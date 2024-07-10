import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math';

import '../data/themedata.dart';
import '../results/resvar.dart';

class CreateStar extends StatefulWidget {
  const CreateStar({super.key});

  @override
  State<CreateStar> createState() => _CreateStarState();
}

class _CreateStarState extends State<CreateStar> {
  final massController = TextEditingController();
  final lumController = TextEditingController();
  final tempController = TextEditingController();

  void setData() async {
    resHead = 'Star Created';

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

    num radiusinm =
        pow(((lum * 3.828e26) / (4 * 3.14 * 5.67e-8 * pow(temp, 4))), 0.5);
    num massinkg = mass * 1.989e30;
    double diameter = (2 * radiusinm / 1000);
    double area = (1.256e-5 * pow(radiusinm, 2));
    double volume = (4.187e-9 * pow(radiusinm, 3));
    double density = (massinkg * 1e-12) / volume;
    double gravity = (6.67e-11 * massinkg) / pow(radiusinm, 2);
    double escvel = pow((2 * 6.67e-11 * massinkg / radiusinm), 0.5) / 1000;

    num radinsolar = radiusinm / 6.9634e8;
    String startype = '';
    String evostage = '';
    String lumclass = '';
    if (lum >= 10000 && radinsolar >= 30 && temp >= 8400) {
      startype = 'Blue Supergiant';
      evostage = 'Supergiant';
      lumclass = 'Class I';
    } else if (lum >= 10000 && temp <= 5000) {
      startype = 'Red Supergiant';
      evostage = 'Supergiant';
      lumclass = 'Class I';
    } else if (lum >= 1000 && temp > 5000 && temp < 8400) {
      startype = 'Bright Giant';
      evostage = 'Bright Giant';
      lumclass = 'Class II';
    } else if (lum >= 10 && radinsolar >= 8 && temp > 2000 && temp < 5000) {
      startype = 'Red Giant';
      evostage = 'Giant';
      lumclass = 'Class III';
    } else if (lum < 1 && radinsolar <= 0.1 && temp > 5000) {
      startype = 'White Dwarf';
      evostage = 'White Dwarf';
      lumclass = 'Class VII';
    } else {
      startype = 'Main Sequence';
      evostage = 'Main Sequence';
      lumclass = 'Class V';
    }

    String specclass = '';
    String color = '';
    if (temp >= 33000) {
      specclass = 'O';
      color = 'Blue';
    } else if (temp >= 10000) {
      specclass = 'B';
      color = 'Blue-White';
    } else if (temp >= 7500) {
      specclass = 'A';
      color = 'White';
    } else if (temp >= 6000) {
      specclass = 'F';
      color = 'Yellow-White';
    } else if (temp >= 5200) {
      specclass = 'G';
      color = 'Yellow';
    } else if (temp >= 3700) {
      specclass = 'K';
      color = 'Orange';
    } else {
      specclass = 'M';
      color = 'Red';
    }

    String img = 'assets/portrait.jpg';
    if (startype == 'Blue Supergiant') {
      img = 'assets/bluesupergiant.jpg';
    } else if (startype == 'Red Supergiant') {
      img = 'assets/transit.jpg';
    } else if (startype == 'Bright Giant') {
      img = 'assets/brightgiant.jpg';
    } else if (startype == 'Red Giant') {
      img = 'assets/redgiant.jpg';
    } else if (startype == 'White Dwarf') {
      img = 'assets/whitedwarf.jpg';
    } else if (startype == 'Main Sequence' &&
        (color == 'Blue' || color == 'Blue-White')) {
      img = 'assets/bluemainseq.jpg';
    } else if (startype == 'Main Sequence' &&
        (color == 'Red' || color == 'Orange')) {
      img = 'assets/reddwarf.jpg';
    } else {
      img = 'assets/yellowmainseq.jpg';
    }

    String dataString = """
      Star Type: $startype
      Evol. Stage: $evostage\n
      Luminosity: ${format(lum)} L☉
      Lum. Class: $lumclass\n
      Conv. Color: $color
      Spectral Class: Class $specclass
      Surf. Temperature: $temp K\n
      Mass: ${format(mass)} M☉
      Avg. Density: ${format(density)} g/cm³
      Surf. Gravity: ${format(gravity)} m/s²
      Escape Velocity: ${format(escvel)} km/s\n
      Diameter: ${format(diameter)} km
      Surf. Area: ${format(area)} km²
      Volume: ${format(volume)} km³\n
      """;

    resImgPath = img;
    resBody = dataString;
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) await precacheImage(Image.asset(resImgPath).image, context);
    if (mounted) Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    Padding textInput(TextEditingController ctr, String hint) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: TextField(
          controller: ctr,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.left,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 18),
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
            titleText(18, 'Mass (Solar Masses)'),
            spacing(),
            textInput(massController, 'Mass'),
            dspacing(),
            titleText(18, 'Luminosity (Solar Lum.)'),
            spacing(),
            textInput(lumController, 'Luminosity'),
            dspacing(),
            titleText(18, 'Surface Temperature (K)'),
            spacing(),
            textInput(tempController, 'Temperature'),
            spacing(),
            dspacing(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: SizedBox(
                height: screenHeight * 0.09,
                child: ElevatedButton(
                  style: btnStyle,
                  onPressed: setData,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      Text(
                        'Create Star',
                        style: fontText(24),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}
