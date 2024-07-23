import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgresStep extends StatelessWidget {
  const ProgresStep({super.key, required this.step});
  final int step;
  @override
  Widget build(BuildContext context) {
    if (step == 1) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(
            'assets/images/step1.svg',
            width: 50,
            height: 50,
          ));
    } else if (step == 2) {
      return Container(child: SvgPicture.asset('assets/images/step2.svg'));
    } else if (step == 3) {
      return Container(child: SvgPicture.asset('assets/images/step3.svg'));
    } else {
      return Text('error');
    }
  }
}
