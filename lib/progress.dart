import 'package:flutter/material.dart';

class MyProgress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProgressState();
  }
}


class MyProgressState extends State<MyProgress> {
  @override
  Widget build(BuildContext context) {
    num width = (MediaQuery.of(context).size.width.round()) - 140.0;
    // num width = 280 * 0.8;
    // return Container(
      // width: width,
      // height: 10,
      // child: ClipRRect(
      return SizedBox(
        height: 10.0,
        width: width,
        // 圆角矩形剪裁（`ClipRRect`）组件，使用圆角矩形剪辑其子项的组件。
        child: ClipRRect(
          // 边界半径（`borderRadius`）属性，圆角的边界半径。
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: LinearProgressIndicator(
            value: 0.6,
            backgroundColor: Color(0xffebedf0),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff7bccd6)),
          ),
        ),
    // ) 
    );
  }
}