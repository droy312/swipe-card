import 'package:flutter/material.dart';
import 'package:swipe_card/swipe_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String mozilla_firefox_logo = 'assets/mozilla_firefox_logo.png';
  static const String dribbble_logo = 'assets/dribbble_logo.png';
  static const String flutter_logo = 'assets/flutter_logo.png';

  static const String mozilla_firefox_body =
      "Firefox Browser, also known as Mozilla Firefox or simply Firefox, is a free and open-source web browser";
  static const String dribbble_body =
      "Dribbble is a self-promotion and social networking platform for digital designers and creatives";
  static const String flutter_body =
      "Flutter is an open-source UI software development kit created by Google";

  static Widget card({
    String? title,
    String? body,
    String? image,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 8,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          image != null
              ? Image.asset(
                  image,
                  height: 150,
                  width: 150,
                  fit: BoxFit.fitHeight,
                )
              : Container(),
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            body ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> list = [
    card(
      title: "Mozilla Firefox",
      body: mozilla_firefox_body,
      backgroundColor: Color.fromRGBO(169, 50, 216, 1),
      image: mozilla_firefox_logo,
      textColor: Colors.white,
    ),
    card(
      title: "Dribbble",
      body: dribbble_body,
      backgroundColor: Color.fromRGBO(231, 77, 137, 1),
      image: dribbble_logo,
      textColor: Colors.white,
    ),
    card(
      title: "Flutter",
      body: flutter_body,
      backgroundColor: Colors.grey[100],
      image: flutter_logo,
      textColor: Colors.black87,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[600],
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          alignment: Alignment.center,
          child: SwipeCard(
            widgetList: list,
            dragLength: 100,
          ),
        ),
      ),
    );
  }
}
