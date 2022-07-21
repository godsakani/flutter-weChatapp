import 'package:flutter/material.dart';
import 'package:wechat/utils/constant.dart';

class ButtonField extends StatelessWidget {
  ButtonField({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  final String text;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.all(21),
        child: Center(
          child: GestureDetector(
            onTap: ontap,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
