import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildStep3Page extends StatelessWidget {
  const BuildStep3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.network(
              'https://appdata.uz/qbb-data/step3.svg',
              width: 50,
              height: 50,
            )),
      ],
    );
  }
}
