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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (() {
        if (isDarkTheme) {
          return Colors.black;
        }
        return Colors.white;
      }()),
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
                color: (() {
                  if (isDarkTheme) {
                    return Colors.white;
                  }
                  return Colors.black;
                }()),
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
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    "DEVELOPER INFO",
                    style: TextStyle(
                      color: HexColor.fromHex("#9C9C9C"),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Telegram: @denver_bot",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Instagram: @denver.lade.py",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Snapchat: @igor.savenko",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "APPLICATION INFO",
                    style: TextStyle(
                      color: HexColor.fromHex("#9C9C9C"),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Name: $appName",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Version: v$version",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Package name: $packageName",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Build number: v$buildNumber",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "NEWS & DONATION LINKS",
                    style: TextStyle(
                      color: HexColor.fromHex("#9C9C9C"),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Telegram: @noto_app",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Instagram: @comming_soon",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Patreon: @coming_soon",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "PayPal: @coming_soon",
                    style: TextStyle(
                      color: (() {
                        if (isDarkTheme) {
                          return Colors.white;
                        }
                        return Colors.black;
                      }()),
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
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
