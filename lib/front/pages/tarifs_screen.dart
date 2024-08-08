import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/appbar_title.dart';
import 'package:qoriqlash_xizmati/front/components/object_flat_container.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/flat/texnik_flat.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/texnik_object.dart';

class SendRequestSafingScreen extends StatelessWidget {
  const SendRequestSafingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          AppbarTitle(),
          ObjectFlatContainer(
              image: 'assets/images/image.png',
              text: 'Obyektingizni qo\'riqlovga topshiring',
              route: TexnikObject()),
          ObjectFlatContainer(
              image: 'assets/images/flat.png',
              text: 'Xonadoningizni qo\'riqlovga topshiring',
              route: TexnikFlat()),
        ],
      ),
    );
  }
}
