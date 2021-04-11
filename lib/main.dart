import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import 'slide_ruler.dart';
import 'progress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  // NumberFormat _numberFormat = NumberFormat(',000');

  @override
  Widget build(BuildContext context) {
    num padding = (MediaQuery.of(context).size.width.round() * 0.3);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(height: 200),
              // MyProgress(),
              _buildTitle(), 
              Container(height: MediaQuery.of(context).size.height.round() * 0.24),
              HorizontalNumberPickerWrapper(
                initialValue: 28,
                minValue: 0,
                maxValue: 120,
                step: 1,
                unit: '',
                widgetWidth: MediaQuery.of(context).size.width.round() - 30,
                subGridCountPerGrid: 10,
                subGridWidth: 12,
                onSelectedChanged: (value) {
                  print(value);
                },
              ),
              Container(height: MediaQuery.of(context).size.height.round() * 0.26),
              // 底部按钮
              RaisedButton(
                color: Color(0xff7bccd6),
                padding: EdgeInsets.fromLTRB(padding, 18, padding, 18),
                onPressed: () {
                  // print(const MediaQuery.of(context).size.height);
                },
                child: Text('Continue',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                // 圆角
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
              ),
              // FlatButton(
              //   padding: EdgeInsets.fromLTRB(46, 10, 46, 10),
              //   splashColor: Colors.blue,
              //   child: Text("Continue"),
              //   textColor: Color(0xffFfffff),
              //   color: YColors.colorPrimary,
              //   highlightColor: Color(0xffF88B0A),
              //   onPressed: ()=>print('onPressed'),
              // )
              ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildTitle() {
    return Container(
        height: 70,
        // color: Color(0x4484FFFF),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                padding: EdgeInsets.fromLTRB(15, 0, 25, 0),
                onPressed: () {},
                icon: Icon(Icons.keyboard_arrow_left, color: Colors.black38, size: 40),
                highlightColor: Colors.grey, 
                splashColor: Colors.white, 
              ),
            ),
            // Padding(
            //   child: Icon(Icons.keyboard_arrow_left, color: Colors.black38, size: 30),
            //   padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
            // ),
            MyProgress(),
            // Expanded(
            //   child: Text(
            //     "附近",
            //     style: TextStyle(fontSize: 18),
            //   ),
            // ),
            Padding(
              child: Text('1/8',style: TextStyle(fontSize: 18.0,color: Colors.black)),
              padding: EdgeInsets.only(left: 25),
            ),
          ],
        ));
  }
}

///去掉整数后的小数点和0
String formatIntegerStr(num number) {
  int intNumber = number.truncate();

  //是整数
  if (intNumber == number) {
    return intNumber.toString();
  } else {
    return number.toString();
  }
}

class YColors {
  static const Color colorPrimary = Color(0xff7bccd6);
}