import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart' show FlutterTts;

import '../data/globals.dart';
import '../results/resvar.dart';
import 'messierdata.dart';

class DeepSky extends StatefulWidget {
  const DeepSky({super.key});

  @override
  State<DeepSky> createState() => _DeepSkyState();
}

class _DeepSkyState extends State<DeepSky> {
  String messierSelection = '';

  late FlutterTts flutterTts;
  IconData icon = Icons.volume_up_rounded;

  @override
  void initState() {
    super.initState();
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
    if (!messier.contains(name)) {
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
    if (mounted) await precacheImage(Image.asset(resImgPath).image, context);
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

    Center catalogDropdown(List<String> list) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Autocomplete<String>(
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) =>
                    TextField(
              controller: textEditingController,
              focusNode: focusNode,
              onChanged: (value) {
                messierSelection = value;
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Select',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: txtColor, width: 0.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: txtColor, width: 1.6),
                ),
                fillColor: Colors.black26,
                filled: true,
              ),
            ),
            optionsViewBuilder:
                (context, Function(String) onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.black87,
                  child: SizedBox(
                    height: (options.length < 5) ? options.length * 56 : 56 * 5,
                    width: screenWidth * 0.74,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return ListTile(
                          title: Text(option,
                              style: const TextStyle(color: Colors.white)),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return list.where((String option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              messierSelection = selection;
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
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
            catalogDropdown(messier),
            dspacing(),
            uiButton(() {
              selectMessier(messierSelection);
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
                  image: AssetImage('assets/messier.jpg'),
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
            const Text(
              messierInfo,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}
