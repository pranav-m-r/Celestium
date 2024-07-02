import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart' show FlutterTts;
import 'package:astroquest/globals.dart';
import 'package:astroquest/results/resvar.dart';

class DeepSky extends StatefulWidget {
  const DeepSky({super.key});

  @override
  State<DeepSky> createState() => _DeepSkyState();
}

class _DeepSkyState extends State<DeepSky> {
  final messierController = TextEditingController();
  final String messierInfo =
      "Although there are as many as one hundred billion comets in the outer regions of the solar system, prior to 1995, only around 900 had ever been discovered. This is because most comets are too dim to be detected without the proper astronomical equipment. Occasionally, however, a comet will sweep past the Sun that is bright enough to be seen during the daytime with the naked eye.\n\nOne such instance occurred in 1744. Comet Klinkenberg-Chéseaux, discovered by three amateur astronomers in late 1743, grew steadily brighter as it approached the Sun. By the end of February 1744, the comet had become the brightest object in the sky except for the Sun and Moon. The comet’s brilliance captured the interest of professional and amateur astronomers alike, including a young Charles Messier.\n\nBorn in 1730 in Badonviller, France, Messier had to give up formal education at age 11 when his father died. Soon after, he witnessed the spectacular Comet Klinkenberg-Chéseaux, which ignited his passion for astronomy. At the age of 21, Messier was hired as a draftsman for the French navy. He learned to use astronomical tools and became a skilled observer. For his efforts, Messier was eventually promoted to the chief astronomer of the Marine Observatory in Paris, where he pursued his interest in comets. He discovered over a dozen comets, earning him the nickname “Comet Ferret” from King Louis XV.\n\nIn 1758, Messier was in the process of observing one such comet when he was distracted by a cloudy object in the constellation Taurus. Upon further observation, he realized that the object could not be a comet because it was not moving across the sky. In an effort to prevent other astronomers from mistaking the object for a comet, Messier took note of it and began to catalog other comet-like “objects to avoid.”\n\nThis comet-like object that Messier observed was NGC 1952. Commonly known today as M1 (Messier 1) or the Crab Nebula, it is the first object in Messier’s Catalog of Nebulae and Star Clusters. By the time of his death in 1817, Messier had compiled a list of 103 objects in the night sky using his own observations with various telescopes and the discoveries of other astronomers.\n\nThe catalog was revised in the 20th century and now contains 110 objects. Amateur astronomers today use Messier’s catalog as a guide to some of the most interesting and detailed cosmic sights that can be viewed from the Northern Hemisphere.";

  List<String> messier = [];

  late FlutterTts flutterTts;
  IconData icon = Icons.volume_up_rounded;

  void initList() {
    setState(() {
      for (int i = 1; i <= 110; i++) {
        messier.add('M$i');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (messier.isEmpty) {
      initList();
    }
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  void textToSpeech() async {
    if (icon == Icons.volume_up_rounded) {
      setState(() {
        icon = Icons.volume_off_rounded;
      });
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak(messierInfo);
      if (mounted) {
        setState(() {
          icon = Icons.volume_up_rounded;
        });
      }
    } else {
      setState(() {
        icon = Icons.volume_up_rounded;
      });
      await flutterTts.stop();
    }
  }

  void selectMessier(String name) async {
    if (!messier.contains(messierController.text)) {
      showErrorMessage('Please select an object from the list!', context);
      return;
    }
    List<Map> list =
        await db.query('messier', where: 'name = ?', whereArgs: [name]);
    Map data = list[0];

    String dataString = """
      ${data['desc']}\n
      Size: ${data['size']}'
      Magnitude: ${data['mag']}
      Distance: ${format(double.parse(data['dist']))} ly\n
      Type: ${data['type']}
      Catalog ID: ${data['catalog']}
      Constellation: ${data['const']}
      """;
    
    resHead = name.replaceAll('M', 'Messier ');
    resImgPath = "assets/${list[0]['img']}.jpg";
    resBody = dataString;
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    Padding uiButton(void Function() fxn, String txt) {
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
                const Icon(Icons.search, size: 27),
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

    Center catalogDropdown(TextEditingController ctr, List<String> list) {
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
          menuHeight: screenHeight * 0.3,
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
        appBar: appBar('Sky Catalogs'),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            text(20, 'Search the Messier catalog:'),
            dspacing(),
            catalogDropdown(messierController, messier),
            dspacing(),
            uiButton(() {
              selectMessier(messierController.text);
            }, 'Select Object'),
            dspacing(),
            spacing(),
            text(20, 'History & Background:'),
            dspacing(),
            Container(
              height: screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: txtColor,
                  width: 1,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/Ms.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            dspacing(),
            Center(
              child: SizedBox(
                height: screenWidth * 0.2,
                width: screenWidth * 0.2,
                child: IconButton(
                  icon: Icon(icon),
                  style: pageBtnStyle,
                  iconSize: 50,
                  onPressed: () {
                    textToSpeech();
                  },
                ),
              ),
            ),
            dspacing(),
            Text(
              messierInfo,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}
