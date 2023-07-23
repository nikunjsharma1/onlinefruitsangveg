import 'package:flutter/material.dart';
import 'package:online_fruits_and_vegetables_app/utils/color_constant.dart';
import 'package:online_fruits_and_vegetables_app/widgets/round_button.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper({
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue,
    required this.iconSize,
    required this.value,
    required this.onChanged,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
    int value=0;
  final ValueChanged<dynamic> onChanged;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(

        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              widget.value = widget.value == widget.lowerLimit
                  ? widget.lowerLimit
                  : widget.value -= widget.stepValue;
              this.widget.onChanged(widget.value);
            });

          }),
      Container(

        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor),
          borderRadius: BorderRadius.circular(9),
        ),
        width: 40,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '${widget.value}',
              style: kTitleStyle,
            ),
          ),
        ),
      ), // Container
      IconButton(icon: Icon(Icons.add), onPressed: () {
        setState(() {
          widget.value = widget.value == widget.upperLimit
              ? widget.upperLimit
              : widget.value += widget.stepValue;
          this.widget.onChanged(widget.value);
        });
      }),
    ]));
  }
}
