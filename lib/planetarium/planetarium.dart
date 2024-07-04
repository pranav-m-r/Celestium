import 'package:flutter/material.dart';

import '../data/globals.dart';
import '../results/resvar.dart';

class Planetarium extends StatefulWidget {
  const Planetarium({super.key});

  @override
  State<Planetarium> createState() => _PlanetariumState();
}

class _PlanetariumState extends State<Planetarium> {
  final pageController = PageController();
  int currentPage = 0;

  void selectPlanet(String planet) async {
    List<Map> list =
        await db.query('planets', where: 'name = ?', whereArgs: [planet]);

    resHead = planet;
    resImgPath = 'assets/${planet.toLowerCase()}img.jpg';

    Map data = list[0];

    String complbl = 'Atmospheric';
    if (planet == 'Moon' || planet == 'Mercury') complbl = 'Elemental';

    String distlbl = 'Sun';
    String perlbl = 'Perihelion';
    String aplbl = 'Aphelion';
    if (planet == 'Moon') {
      distlbl = 'Earth';
      perlbl = 'Perigee';
      aplbl = 'Apogee';
    }

    String dataString = """
      ${data['desc']}\n
      Mass: ${data['mass']} x 10^24 kg
      Diameter: ${data['diameter']} km
      Avg. Density: ${data['density']} kg/m^3\n
      Surf. Gravity: ${data['gravity']} m/s^2
      Escape Velocity: ${data['escvel']} km/s\n
      Surf. Pressure: ${data['press']} atm
      Mean Temperature: ${data['temp']} °C\n
      Rotation Period: ${data['rotper']} hours
      Length of Day: ${data['day']} hours
      Axial Tilt: ${data['axialtilt']} degrees\n
      Orbital Period: ${data['orbper']} days
      Orbital Velocity: ${data['orbvel']} km/s
      Orbital Inclination: ${data['orbinc']} degrees
      Orbital Eccentricity: ${data['orbecc']}\n
      Distance ($distlbl): ${data['dist']} x 10^6 km
      $perlbl: ${data['perhel']} x 10^6 km
      $aplbl: ${data['aphel']} x 10^6 km\n
      Ring System: ${data['ring']}
      Number of Moons: ${data['moons']}\n
      Global Magnetic Field: ${data['magfield']}\n
      $complbl Composition:\n${data['comp']}\n
      """;

    resBody = dataString;
    if (mounted) Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    const List<String> topics = [
      'Mercury',
      'Venus',
      'Earth',
      'Moon',
      'Mars',
      'Jupiter',
      'Saturn',
      'Uranus',
      'Neptune',
    ];

    Center imgButton(String text, String image) {
      return Center(
        child: GestureDetector(
            onTap: () {
              selectPlanet(text);
            },
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                border: Border.all(
                  color: txtColor,
                  width: 1,
                ),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.darken),
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )),
      );
    }

    Column plPage(int page) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          imgButton(
              topics[3 * page], "assets/${topics[3 * page].toLowerCase()}.jpg"),
          imgButton(topics[3 * page + 1],
              "assets/${topics[3 * page + 1].toLowerCase()}.jpg"),
          imgButton(topics[3 * page + 2],
              "assets/${topics[3 * page + 2].toLowerCase()}.jpg"),
        ],
      );
    }

    return Container(
        decoration: background,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar('Planetarium'),
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    children: <Widget>[
                      plPage(0),
                      plPage(1),
                      plPage(2),
                    ],
                  ),
                ),
                SizedBox(height: padding * 0.4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),
                      style: pageBtnStyle,
                      iconSize: 26,
                      onPressed: () {
                        if (pageController.page == 0) {
                          pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 750),
                              curve: Curves.easeInOut);
                        } else {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    Text(
                      'Page ${currentPage + 1}',
                      style: const TextStyle(fontSize: 20, color: txtColor),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                      ),
                      style: pageBtnStyle,
                      iconSize: 26,
                      onPressed: () {
                        if (pageController.page == 2) {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 750),
                              curve: Curves.easeInOut);
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: padding * 0.8),
              ],
            )));
  }
}
