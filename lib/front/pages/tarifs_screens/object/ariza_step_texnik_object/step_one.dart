import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class BuildStep1Page extends StatelessWidget {
  const BuildStep1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    'Hududni tanlang',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ]),
              ],
            ))
      ],
    );
  }
}
