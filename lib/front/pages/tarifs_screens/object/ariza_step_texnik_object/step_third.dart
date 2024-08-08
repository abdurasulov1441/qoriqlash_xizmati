import 'package:flutter/material.dart';

class BuildStep3Page extends StatelessWidget {
  final String? obyektTuri;
  final String? qoriqlashVositasi;
  final Map<String, TimeOfDay>? qoriqlashVaqtlari;

  const BuildStep3Page({
    Key? key,
    this.obyektTuri,
    this.qoriqlashVositasi,
    this.qoriqlashVaqtlari,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Obyekt Turi: $obyektTuri'),
          Text('Qo\'riqlash Vositalari: $qoriqlashVositasi'),
          ...?qoriqlashVaqtlari?.entries.map((entry) => Text(
              '${entry.key}: ${entry.value.format(context)}')).toList(),
        ],
      ),
    );
  }
}
