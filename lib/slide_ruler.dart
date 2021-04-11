import 'package:flutter/material.dart';
import 'slide_ruler_scale.dart';

///对HorizontalNumberPicker进行简单包装，添加顶部的选中值显示和两边的半透明遮罩
// ignore: must_be_immutable
class HorizontalNumberPickerWrapper extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final String unit;

  ///控件的宽度
  final int widgetWidth;

  ///一大格中有多少个小格
  final int subGridCountPerGrid;

  ///每一小格的宽度
  final int subGridWidth;

  final void Function(int) onSelectedChanged;

  ///返回上方大标题所展示的数值字符串
  String Function(int) titleTransformer;

  ///返回标尺刻度所展示的数值字符串
  final String Function(int) scaleTransformer;

  ///标题文字颜色
  final Color titleTextColor;

  ///刻度颜色
  final Color scaleColor;

  ///指示器颜色
  final Color indicatorColor;

  ///刻度文字颜色
  final Color scaleTextColor;

  HorizontalNumberPickerWrapper({
    Key key,
    this.initialValue = 500,
    this.minValue = 100,
    this.maxValue = 900,
    this.step = 1,
    this.unit = "",
    this.widgetWidth = 200,
    this.subGridCountPerGrid = 10,
    this.subGridWidth = 8,
    @required this.onSelectedChanged,
    this.titleTransformer,
    this.scaleTransformer,
    this.titleTextColor = const Color(0xff7bccd6),
    this.scaleColor = const Color(0xFFE9E9E9),
    this.indicatorColor = const Color(0xff7bccd6),
    this.scaleTextColor = const Color(0xFF8E99A0),
  }) : super(key: key) {
    if (titleTransformer == null) {
      titleTransformer = (value) {
        return value.toString();
      };
    }
  }

  @override
  State<StatefulWidget> createState() {
    return HorizontalNumberPickerWrapperState();
  }
}

class HorizontalNumberPickerWrapperState extends State<HorizontalNumberPickerWrapper> {
  int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  ///处理state的复用
  void didUpdateWidget(HorizontalNumberPickerWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    int numberPickerHeight = 80;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //上方选中值
        _selectedBox(),
        Container(width: 0, height: 20),
        //可滚动标尺
        Stack(
          children: <Widget>[
            HorizontalScale(
              initialValue: widget.initialValue,
              minValue: widget.minValue,
              maxValue: widget.maxValue,
              step: widget.step,
              widgetWidth: widget.widgetWidth,
              widgetHeight: numberPickerHeight,
              subGridCountPerGrid: widget.subGridCountPerGrid,
              subGridWidth: widget.subGridWidth,
              onSelectedChanged: (value) {
                widget.onSelectedChanged(value);
                setState(() {
                  _selectedValue = value;
                });
              },
              scaleTransformer: widget.scaleTransformer,
              scaleColor: widget.scaleColor,
              indicatorColor: widget.indicatorColor,
              scaleTextColor: widget.scaleTextColor,
            ),
            //左右半透明遮罩
            Positioned(
              left: 0,
              child: Container(
                width: 20,
                height: numberPickerHeight.toDouble(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0)
                  ]),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 20,
                height: numberPickerHeight.toDouble(),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0.8)
                  ]),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _selectedBox() {
    return Stack(
      overflow: Overflow.visible,
      children: [
      Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80)),
          color: Color(0xffecf4fb),
        ),
        child: Text(
          widget.titleTransformer(_selectedValue),
          style: TextStyle(
            color: Color(0xff535a60),
            fontSize: 40,
            fontWeight: FontWeight.bold,
            //fontFamily: "Montserrat",
          ),
        ),
      ),
      
      Positioned(
        left: 40,
        bottom: -8,
        child: Container(
          width: 20,
          height: 10,
          decoration: BoxDecoration(
            border: Border(
              // 四个值 top right bottom left
              top: BorderSide(
                  color: Color(0xffecf4fb),
                  width: 16,
                  style: BorderStyle.solid),
              right: BorderSide(
                  color: Colors.transparent,
                  width: 12,
                  style: BorderStyle.solid),
              left: BorderSide(
                  color: Colors.transparent,
                  width: 12,
                  style: BorderStyle.solid),
            ),
          ),
        ),
      )
    ]);
  }
}
