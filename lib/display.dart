import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

class HomePageForCalc extends StatefulWidget {
  @override
  _HomePageForCalcState createState() => _HomePageForCalcState();
}

class _HomePageForCalcState extends State<HomePageForCalc> {
//Logic
  String equestion = '';
  String result = '';
  String expression = '';
  buttonClick(String buttonText) {
    setState(() {
      if (buttonText == 'c') {
        equestion = equestion.substring(0, equestion.length - 1);
      } else if (buttonText == 'Cl') {
        equestion = '';
        result = '';
      } else if (buttonText == '=') {
        expression = equestion;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'math error';
        }
      } else if (equestion.length >= 60) {
        result = 'only 60 digits';
      }else {
        equestion = equestion + buttonText;
      }
    });
  }

  Widget myButtons(String buttonText, Color buttonColor) {
    return FlatButton(
      splashColor: Colors.transparent,
      padding: EdgeInsets.all(15.0),
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Colors.white,
          width: .1,
          style: BorderStyle.solid,
        ),
      ),
      onPressed: () => buttonClick(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black,
          title: Text('Calculator'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //DisplayFor Calculator
              //equestion display
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equestion,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              //result display
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  result,
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  myButtons('Cl', Colors.red[900]),
                  myButtons('÷', Colors.deepPurple),
                  myButtons('x', Colors.deepPurple),
                  myButtons('c', Colors.deepPurple),
                ],
              ),
              //next
              SizedBox(
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  myButtons('7', Colors.grey[500]),
                  myButtons('8', Colors.grey[500]),
                  myButtons('9', Colors.grey[500]),
                  myButtons('-', Colors.deepPurple),
                ],
              ),
              //next
              SizedBox(
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  myButtons('4', Colors.grey[500]),
                  myButtons('5', Colors.grey[500]),
                  myButtons('6', Colors.grey[500]),
                  myButtons('+', Colors.deepPurple),
                ],
              ),
              //next
              SizedBox(
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  myButtons('1', Colors.grey[500]),
                  myButtons('2', Colors.grey[500]),
                  myButtons('3', Colors.grey[500]),
                  myButtons('.', Colors.deepPurple),
                ],
              ),
              //next
              SizedBox(
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  myButtons('0', Colors.grey[500]),
                  myButtons('%', Colors.grey[500]),
                  myButtons('00', Colors.grey[500]),
                  myButtons('=', Colors.green[900]),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
