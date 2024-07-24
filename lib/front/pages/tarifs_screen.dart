import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/appbar_title.dart';
import 'package:qoriqlash_xizmati/front/components/object_flat_container.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/flat/flat_security.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/object_security.dart';

class SendRequestSafingScreen extends StatelessWidget {
  const SendRequestSafingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          AppbarTitle(),
          ObjectFlatContainer(
            image: 'https://appdata.uz/qbb-data/image.png',
            text: 'Obyektingizni qo\'riqlovga topshiring',
            route: ObjectSecurity(),
          ),
          ObjectFlatContainer(
            image: 'https://appdata.uz/qbb-data/flat.png',
            text: 'Xonadoningizni qo\'riqlovga topshiring',
            route: FlatSecurity(),
          ),
        ],
      ),
    );
  }
}