import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:astroquest/globals.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void>? launched;

  Future<void> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  Future<void> openUrl(Uri url) async {
    if (!await launchUrl(url)) {
      if (mounted) showErrorMessage('Could not launch $url', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    SizedBox webButton(String url, String txt, Widget icon) {
      double y = 0.09;
      return SizedBox(
        height: screenHeight * y,
        child: ElevatedButton(
          style: style,
          onPressed: () => setState(() {
            launched = openUrl(Uri.parse(url));
          }),
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
                size: 25,
              ),
            ],
          ),
        ),
      );
    }

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    getVersion();

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black26,
          title: const Text('Astro Quest'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            Center(
              child: Text(
                '© 2020-24 Astro Gen-Z',
                style: TextStyle(fontSize: 18, color: textColor),
              ),
            ),
            spacing(),
            Center(
              child: Text(
                'Astro Quest v$version',
                style: TextStyle(fontSize: 25, color: textColor),
              ),
            ),
            spacing(),
            spacing(),
            webButton("https://astrogenz.wixsite.com/astrogenz", "Website",
                const Icon(Icons.language, size: 25)),
            spacing(),
            webButton("https://astrogenz.wixsite.com/astrogenz/policy",
                "Privacy", const Icon(Icons.policy, size: 25)),
            spacing(),
            webButton("https://astrogenz.wixsite.com/astrogenz/credits",
                "Credits", const Icon(Icons.copyright, size: 25)),
            spacing(),
            webButton("https://astrogenz.wixsite.com/astrogenz/contact",
                "Contact", const Icon(Icons.email, size: 25)),
            spacing(),
            webButton("https://youtube.com/@astrogen-z", "YouTube",
                const ImageIcon(AssetImage("assets/youtube.png"), size: 23)),
            spacing(),
            webButton(
                "https://play.google.com/store/apps/dev?id=9125981999068904156",
                "Play Store",
                const ImageIcon(AssetImage("assets/googleplay.png"), size: 21)),
          ],
        ),
      ),
    );
  }
}
