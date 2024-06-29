import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
import 'package:astroquest/results/resvar.dart';

class DeepSky extends StatefulWidget {
  const DeepSky({super.key});

  @override
  State<DeepSky> createState() => _DeepSkyState();
}

class _DeepSkyState extends State<DeepSky> {
  final messierController = TextEditingController();

  List<String> messier = [];

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
  }

  void selectMessier(String name) async {
    if (!messier.contains(messierController.text)) {
      showErrorMessage('Please select an object from the list!', context);
      return;
    }
    List<Map> list =
        await db.query('messier', where: 'name = ?', whereArgs: [name]);
    resHead = name.replaceAll('M', 'Messier ');
    resImgPath = "assets/${list[0]['img']}.jpg";
    resBody = list[0]['desc'];
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) Navigator.pushNamed(context, '/result');
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
            }, 'Select Object', const Icon(Icons.search, size: 27)),
            spacing(),
          ],
        ),
      ),
    );
  }
}
