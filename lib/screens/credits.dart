import 'package:flutter/material.dart';
import 'package:noto/internal/hex_color.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  bool isDarkTheme = false;
  List tasks = [];
  String appName = "", packageName = "", version = "", buildNumber = "";

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _versionParser();
  }

  _versionParser() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = (prefs.getBool('isDarkTheme') ?? false);
    });
  }

  _themePicker(String obj) {
    switch (isDarkTheme) {
      case true:
        switch (obj) {
          case "scaffold":
            return Colors.black;
          case "image":
          case "text":
            return Colors.white;
        }
        break;
      default:
        switch (obj) {
          case "scaffold":
            return Colors.white;
          case "image":
          case "text":
            return Colors.black;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    List credits = [
      [
        "DEVELOPER INFO",
        [
          "Telegram: @denver_bot",
          "Instagram: @denver.lade.py",
          "Snapchat: @igor.savenko"
        ],
      ],
      [
        "APPLICATION INFO",
        [
          "Name: $appName",
          "Version: v$version",
          "Package name: $packageName",
          "Build number: v$buildNumber",
        ]
      ],
      [
        "NEWS & DONATION LINKS",
        [
          "Telegram: @noto_app",
          "Instagram: @comming_soon",
          "Patreon: @coming_soon",
          "PayPal: @coming_soon"
        ]
      ]
    ];
    return Scaffold(
      backgroundColor: _themePicker("scaffold"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (() {
                Navigator.of(context).pop();
              }),
              child: Image(
                image: const AssetImage("assets/images/bi_x-lg.png"),
                width: 35,
                color: _themePicker("image"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Center(
              child: Column(
                children: [
                  Text(
                    "CREDITS",
                    style: TextStyle(
                      color: _themePicker("text"),
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(credits.length, (index) {
                        return Column(
                          children: [
                            Text(
                              credits[index][0],
                              style: TextStyle(
                                color: HexColor.fromHex("#9C9C9C"),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: List.generate(credits[index][1].length,
                                  (indexText) {
                                return Column(
                                  children: [
                                    Text(
                                      credits[index][1][indexText],
                                      style: TextStyle(
                                        color: _themePicker("text"),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    )
                                  ],
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }),
                    ),
                  ))
                ],
              ),
            )),
            Center(
              child: Text(
                "Made in Ukraine🇺🇦",
                style: TextStyle(
                  color: (() {
                    if (isDarkTheme) {
                      return Colors.white;
                    }
                    return Colors.black;
                  }()),
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
