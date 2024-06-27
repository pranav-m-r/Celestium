import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
import 'package:astroquest/results/resvar.dart';
import 'sadata.dart';
import 'dart:math';

class StarArchive extends StatefulWidget {
  const StarArchive({super.key});

  @override
  State<StarArchive> createState() => _StarArchiveState();
}

class _StarArchiveState extends State<StarArchive> {
  final nameController = TextEditingController();
  final desigController = TextEditingController();
  final random = Random();

  void setData(String name, Map data) {
    resHead = name;
    double mass = data['mass'];
    double lum = data['lum'];
    double mag = data['mag'];
    double dist = data['dist'];
    int temp = data['temp'];
    int multi = data['multi'];

    num radiusinm =
        pow(((lum * 3.828e26) / (4 * 3.14 * 5.67e-8 * pow(temp, 4))), 0.5);
    num massinkg = mass * 1.989e30;
    double diameter = (2 * radiusinm / 1000);
    double area = (1.256e-5 * pow(radiusinm, 2));
    double volume = (4.187e-9 * pow(radiusinm, 3));
    double density = (massinkg * 1e-12) / volume;
    double gravity = (6.67e-11 * massinkg) / pow(radiusinm, 2);
    double escvel = pow((2 * 6.67e-11 * massinkg / radiusinm), 0.5) / 1000;
    double absmag = mag + 5 - 5 * (log(dist / 3.2616) / log(10));

    num radinsolar = radiusinm / 6.9634e8;
    String startype = '';
    String evostage = '';
    String lumclass = '';
    if (lum >= 10000 && radinsolar >= 30 && temp >= 8400) {
      startype = 'Blue Supergiant';
      evostage = 'Supergiant';
      lumclass = 'Class I (1)';
    } else if (lum >= 10000 && temp <= 5000) {
      startype = 'Red Supergiant';
      evostage = 'Supergiant';
      lumclass = 'Class I (1)';
    } else if (lum >= 1000 && temp > 5000 && temp < 8400) {
      startype = 'Bright Giant';
      evostage = 'Bright Giant';
      lumclass = 'Class II (2)';
    } else if (lum >= 10 && radinsolar >= 8 && temp > 2000 && temp < 5000) {
      startype = 'Red Giant';
      evostage = 'Giant';
      lumclass = 'Class III (3)';
    } else if (lum < 1 && radinsolar <= 0.1 && temp > 5000) {
      startype = 'White Dwarf';
      evostage = 'White Dwarf';
      lumclass = 'Class VII (7)';
    } else {
      startype = 'Main Sequence';
      evostage = 'Main Sequence';
      lumclass = 'Class V (5)';
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
    if (multi > 1) {
      img = 'assets/BinaryStar.jpg';
    } else if (startype == 'Blue Supergiant') {
      img = 'assets/BlueSupergiant.jpg';
    } else if (startype == 'Red Supergiant') {
      img = 'assets/transit.jpg';
    } else if (startype == 'Bright Giant') {
      img = 'assets/BrightGiant.jpg';
    } else if (startype == 'Red Giant') {
      img = 'assets/RedGiant.jpg';
    } else if (startype == 'White Dwarf') {
      img = 'assets/WhiteDwarf.jpg';
    } else if (startype == 'Main Sequence' &&
        (color == 'Blue' || color == 'Blue-White')) {
      img = 'assets/BlueMainSequence.jpg';
    } else if (startype == 'Main Sequence' &&
        (color == 'Red' || color == 'Orange')) {
      img = 'assets/RedDwarf.jpg';
    } else {
      img = 'assets/YellowMainSequence.jpg';
    }

    String dataString = """
      ${data['desc']}\n
      Constellation: ${data['const']}\n
      Star Type: $startype
      Evol. Stage: $evostage\n
      Luminosity: ${format(lum)} L☉
      Lum. Class: $lumclass\n
      Surf. Temperature: $temp K
      Spectral Class: Class $specclass
      Conventional Color: $color\n
      Mass: ${format(mass)} M☉
      Avg. Density: ${format(density)} g/cm³
      Surf. Gravity: ${format(gravity)} m/s²
      Escape Velocity: ${format(escvel)} km/s\n
      Diameter: ${format(diameter)} km
      Surf. Area: ${format(area)} km²
      Volume: ${format(volume)} km³\n
      Apparent Magnitude: ${mag.toStringAsFixed(2)}
      Absolute Magnitude: ${absmag.toStringAsFixed(2)}
      Distance From Earth: ${format(dist)} ly\n
      No. Of Stars In The System: $multi
      """;

    resImgPath = img;
    resBody = dataString;
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(context, '/result');
  }

  void selectStarByName() {
    if (!starsByName.contains(nameController.text)) {
      showErrorMessage('Please select a star from the list!', context);
      return;
    }
    setData(nameController.text, starDataByName[nameController.text]);
  }

  void selectStarByDesig() {
    if (!starsByDesig.contains(desigController.text)) {
      showErrorMessage('Please select a star from the list!', context);
      return;
    }
    setData(desigController.text, starDataByDesig[desigController.text]);
  }

  void randomStar() {
    String randomStar = starsByName[random.nextInt(starsByName.length)];
    setData(randomStar, starDataByName[randomStar]);
  }

  void createStar() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(context, '/createstar');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    Padding uiButton(void Function() fxn, String txt, Widget icon) {
      double y = 0.09;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: SizedBox(
          height: screenHeight * y,
          child: ElevatedButton(
            style: btnStyle,
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
        ),
      );
    }

    Center starDropdown(TextEditingController ctr, List<String> list) {
      return Center(
        child: DropdownMenu(
          controller: ctr,
          width: screenWidth * 0.66,
          trailingIcon: const Icon(Icons.arrow_drop_down, color: txtColor),
          selectedTrailingIcon:
              const Icon(Icons.arrow_drop_up, color: txtColor),
          hintText: 'Select',
          enableFilter: true,
          enableSearch: true,
          requestFocusOnTap: true,
          textStyle: const TextStyle(color: Colors.white, fontSize: 18),
          inputDecorationTheme: InputDecorationTheme(
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
          menuStyle: const MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(Color.fromARGB(240, 0, 0, 0)),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          dropdownMenuEntries:
              list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
              style: dropdownStyle,
            );
          }).toList(),
          onSelected: (value) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
        appBar: appBar('Star Archive'),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            text(20, 'Want data on a specific star?'),
            dspacing(),
            text(20, 'Search by common name:'),
            spacing(),
            starDropdown(nameController, starsByName),
            dspacing(),
            uiButton(selectStarByName, 'Select Star',
                const Icon(Icons.search, size: 27)),
            dspacing(),
            text(20, 'Search by designation:'),
            spacing(),
            starDropdown(desigController, starsByDesig),
            dspacing(),
            uiButton(selectStarByDesig, 'Select Star',
                const Icon(Icons.search, size: 27)),
            dspacing(),
            text(20, 'Want to create your own star?'),
            dspacing(),
            uiButton(
                createStar, 'Create Star', const Icon(Icons.create, size: 27)),
            dspacing(),
            text(20, 'Want to learn about a new star?'),
            dspacing(),
            uiButton(
                randomStar, 'Random Star', const Icon(Icons.casino, size: 27)),
            spacing(),
          ],
        ),
      ),
    );
  }
}
