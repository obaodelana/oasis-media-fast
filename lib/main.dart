import 'package:flutter/material.dart';
import 'package:oasis_bible_app/widgets/pages/home.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize
  (
    "LtGoJhJXpYpB3ji8jxDi96OITTAgPwTL3PBUMjiM", // Application ID
    "https://parseapi.back4app.com", // Sever URL
    clientKey: "Sr0soCzQvq17jqglBhh2PY8259C7GzhCJVvlvm7p",
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: "Oasis",
      theme: ThemeData
      (
        fontFamily: "Montserrat",
        primaryColor: const Color(0xFFC7DDD9),
        scaffoldBackgroundColor: const Color(0xFFC7DDD9)
      ),
      home: const Scaffold(body: HomePage()),
    );
  }
}