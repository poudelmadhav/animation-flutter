import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture and Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gesture and Animations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int numTaps = 0;
  int numDoubleTaps = 0;
  int numLongPress = 0;
  double posX = 0.0;
  double posY = 0.0;
  double boxSize = 0.0;
  final double fullBozSize = 150.0;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 5),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    animation.addListener(() {
      setState(() {
        boxSize = fullBozSize * animation.value;
      });
      center(context);
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (posX == 0.0) {
      center(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            numTaps++;
          });
        },
        onDoubleTap: () {
          numDoubleTaps++;
        },
        onLongPress: () {
          numLongPress++;
        },
        onVerticalDragUpdate: (DragUpdateDetails value) {
          setState(() {
            double delta = value.delta.dy;
            posY += delta;
          });
        },
        onHorizontalDragUpdate: (DragUpdateDetails value) {
          setState(() {
            double delta = value.delta.dx;
            posX += delta;
          });
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              left: posX,
              top: posY,
              child: Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColorLight,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Taps: $numTaps - Double Tabs:  $numDoubleTaps, Long Presses: $numLongPress",
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30.0;

    setState(() {
      posX = posX;
      posY = posY;
    });
  }
}
