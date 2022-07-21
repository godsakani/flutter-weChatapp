import 'package:flutter/material.dart';
import 'package:wechat/utils/constant.dart';

class footerField extends StatelessWidget {
  const footerField({
    Key? key,
    required this.text1,
    required this.text2,
    required this.ontap,
  }) : super(key: key);

  final String text1;
  final String text2;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: ontap,
              child: Text(
                text2,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
