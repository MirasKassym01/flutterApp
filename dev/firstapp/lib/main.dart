import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calc(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        // shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator app'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$txt',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('C', Colors.grey, Colors.black),
                calcbutton('+/-', Colors.grey, Colors.black),
                calcbutton('%', Colors.grey, Colors.black),
                calcbutton('/', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('8', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('9', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('x', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('5', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('6', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('-', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('2', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('3', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('+', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    calc('0');
                  },
                  // shape: StadiumBorder(side: BorderSide(width: 0)),
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Colors.grey[850],
                ),
                calcbutton('.', Color.fromRGBO(48, 48, 48, 1), Colors.white),
                calcbutton('=', Color.fromRGBO(255, 160, 0, 1), Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  double firstNum = 0;
  double secondNum = 0;

  dynamic txt = '0';

  dynamic calculation = '';
  dynamic totalCalc = '';
  dynamic operation = '';
  dynamic preOperation = '';
  void calc(btnText) {
    if (btnText == 'C') {
      txt = '0';
      firstNum = 0;
      secondNum = 0;
      calculation = '';
      totalCalc = '0';
      operation = '';
      preOperation = '';
    } else if (operation == '=' && btnText == '=') {
      if (preOperation == '+') {
        totalCalc = adding();
      } else if (preOperation == '-') {
        totalCalc = subtraction();
      } else if (preOperation == 'x') {
        totalCalc = multiple();
      } else if (preOperation == '/') {
        totalCalc = dividing();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (firstNum == 0) {
        firstNum = double.parse(calculation);
      } else {
        secondNum = double.parse(calculation);
      }

      if (operation == '+') {
        totalCalc = adding();
      } else if (operation == '-') {
        totalCalc = subtraction();
      } else if (operation == 'x') {
        totalCalc = multiple();
      } else if (operation == '/') {
        totalCalc = dividing();
      }
      preOperation = operation;
      operation = btnText;
      calculation = '';
    } else if (btnText == '%') {
      calculation = firstNum / 100;
      totalCalc = doesContainDecimal(calculation);
    } else if (btnText == '.') {
      if (!calculation.toString().contains('.')) {
        calculation = calculation.toString() + '.';
      }
      totalCalc = calculation;
    } else if (btnText == '+/-') {
      calculation.toString().startsWith('-')
          ? calculation = calculation.toString().substring(1)
          : calculation = '-' + calculation.toString();
      totalCalc = calculation;
    } else {
      calculation = calculation + btnText;
      totalCalc = calculation;
    }

    setState(() {
      txt = totalCalc;
    });
  }

  String adding() {
    calculation = (firstNum + secondNum).toString();
    firstNum = double.parse(calculation);
    return doesContainDecimal(calculation);
  }

  String subtraction() {
    calculation = (firstNum - secondNum).toString();
    firstNum = double.parse(calculation);
    return doesContainDecimal(calculation);
  }

  String multiple() {
    calculation = (firstNum * secondNum).toString();
    firstNum = double.parse(calculation);
    return doesContainDecimal(calculation);
  }

  String dividing() {
    calculation = (firstNum / secondNum).toString();
    firstNum = double.parse(calculation);
    return doesContainDecimal(calculation);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}