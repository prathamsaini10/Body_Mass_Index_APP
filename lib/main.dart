import 'package:bmi_cal/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        useMaterial3: true,
      ),
      home: SplashScreeen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tf1 = TextEditingController();
  var tf2 = TextEditingController();
  var tf3 = TextEditingController();
  var result = "";
  var bgColor;
  bool isfeet = true;
  @override
  Future<void> clearTextFields() async {
    tf1.clear();
    tf2.clear();
    tf3.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa8edea),
                Color(0xfffed6e3)
                // Colors.greenAccent,//   Colors.blue,
                // Colors.yellow,  //  Colors.white,
                // Colors.red,
              ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.shade300,
            title: const Center(
                child: Text(
                  'BMI Calculator',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white70),
                )),
          ),
          body: Container(
            color: bgColor,
            child: Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                      child: Text(
                        'BMI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black),
                      ),
                    ),
                    Row(children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('Weight:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: tf1,
                          decoration: const InputDecoration(
                            label: Text(
                              'Enter Weight (In Kg)',
                              style: TextStyle(fontSize: 17),
                            ),
                            prefixIcon: Icon(Icons.line_weight_sharp),
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('Heigth:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                )),
                          ),
                          if (isfeet)
                            const Text('feet:',
                                style: TextStyle(
                                  fontSize: 19,
                                )),
                          if (isfeet)
                            SizedBox(
                              width: 80,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: tf2,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.height_sharp),
                                ),
                              ),
                            ),
                          if (isfeet)
                            const Text('Inch:',
                                style: TextStyle(
                                  fontSize: 19,
                                )),
                          if (isfeet)
                            SizedBox(
                              width: 80,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: tf3,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.height_sharp),
                                ),
                              ),
                            ),
                          if (!isfeet)
                            const Text('Centimeter:',
                                style: TextStyle(
                                  fontSize: 19,
                                )),
                          if (!isfeet)
                            SizedBox(
                                width: 80,
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: tf2,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.height_sharp),
                                    )))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ToggleSwitch(
                        activeBgColor: const [Colors.blueGrey],
                        inactiveBgColor: Colors.white,
                        minWidth: 100,
                        initialLabelIndex: 0,
                        cornerRadius: 10,
                        totalSwitches: 2,
                        labels: const ['Feet', 'Centimeter'],
                        changeOnTap: true,
                        onToggle: (index) {
                          setState(() {
                            if (index == 0) {
                              isfeet = true;
                            } else {
                              isfeet = false;
                            }
                          });
                          clearTextFields();
                        },
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)))),
                        onPressed: () {
                          var wt1 = (tf1.text.toString());
                          var ft1 = (tf2.text.toString());
                          var inch1 = (tf3.text.toString());
                          var msg = '';
                          if (isfeet) {
                            if (wt1 != "" && ft1 != "" && inch1 != "") {
                              var wt = double.parse(tf1.text.toString());
                              var ft = double.parse(tf2.text.toString());
                              var inch = double.parse(tf3.text.toString());

                              var Tinch = (ft * 12) + inch;
                              var Tht = (Tinch * 2.54) / 100;
                              var Bmi = wt / (Tht * Tht);

                              if (Bmi > 25) {
                                msg = 'You are OverWeight';
                                bgColor = Colors.red.shade400;
                              } else if (Bmi < 18) {
                                msg = 'You are UnderWeight';
                                bgColor = Colors.blue.shade300;
                              } else {
                                msg = 'You are Healthy ';
                                bgColor = Colors.lightGreen.shade400;
                              }

                              result = "$msg BMI is ${Bmi.toStringAsFixed(2)}";
                              setState(() {});
                            } else {
                              setState(() {
                                result = 'Please fill all the required blanks';
                                bgColor = Colors.transparent;
                              });
                            }
                          }
                          if (!isfeet) {
                            if (wt1 != "" && ft1 != "") {
                              var wt = double.parse(tf1.text.toString());
                              var ft = double.parse(tf2.text.toString());

                              var Tm = ft / 100;
                              var Bmi = wt / (Tm * Tm);
                              if (Bmi > 25) {
                                msg = 'You are OverWeight';
                                bgColor = Colors.red.shade400;
                              } else if (Bmi < 18) {
                                msg = 'You are UnderWeight';
                                bgColor = Colors.blue.shade300;
                              } else {
                                msg = 'You are Healthy ';
                                bgColor = Colors.lightGreen.shade400;
                              }

                              result = "$msg BMI is ${Bmi.toStringAsFixed(2)}";
                              setState(() {});
                            } else {
                              setState(() {
                                result = 'Please fill all the required blanks';
                                bgColor = Colors.transparent;
                              });
                            }
                          }
                        },
                        child: const Text(
                          'calculate',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'FontMaiin',
                              color: Colors.white),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text("$result",
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
