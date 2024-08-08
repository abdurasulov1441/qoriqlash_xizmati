import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qoriqlash_xizmati/front/components/app_data_provider.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/ariza_texnik_object.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class TexnikObject extends StatelessWidget {
  const TexnikObject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [DropDownObjectTexnik()],
        ),
      ),
    );
  }
}

class DropDownObjectTexnik extends StatefulWidget {
  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropDownObjectTexnik> {
  String? _selectedItem1;
  String? _selectedItem2;
  List<String> objectTypes = []; // List to hold the fetched object types

  @override
  void initState() {
    super.initState();
    fetchObjectTypes(); // Fetch data when the widget initializes
  }

  Future<void> fetchObjectTypes() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.100.9.145:7684/api/v1/ref/object-types?parent_id=1'));
      if (response.statusCode == 200) {
        final List<dynamic> data =
            json.decode(utf8.decode(response.bodyBytes)); // Use utf8.decode
        setState(() {
          objectTypes = data.map((item) => item['name'].toString()).toList();
        });
      } else {
        print('Failed to load object types');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showModalForItem1(
      BuildContext context, List<String> items, Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          titlePadding: EdgeInsets.symmetric(vertical: 10),
          title: Center(
              child: Text('Obyekt turini tanlang',
                  style: TextStyle(fontSize: 16))),
          content: Container(
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black)),
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index], style: TextStyle(fontSize: 14)),
                  leading: Radio(
                    value: items[index],
                    groupValue: _selectedItem1,
                    onChanged: (String? value) {
                      setState(() {
                        onSelect(value!);
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tanlash', style: TextStyle(fontSize: 14)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showModalForItem2(
      BuildContext context, List<String> items, Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          titlePadding: EdgeInsets.symmetric(vertical: 0),
          title: Container(
            decoration: BoxDecoration(
                color: AppColors.lightHeaderBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            width: double.infinity,
            height: 35,
            child: Center(
                child: Text('Siz qanday qo\'riqlash vositalarini tanlaysiz',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold))),
          ),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index], style: AppStyle.fontStyle),
                  leading: Radio(
                    value: items[index],
                    groupValue: _selectedItem2,
                    onChanged: (String? value) {
                      setState(() {
                        onSelect(value!);
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightButtonGreen),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tanlash',
                      style: AppStyle.fontStyle
                          .copyWith(color: AppColors.lightHeaderColor))),
            ),
          ],
        );
      },
    );
  }

  void _showTimePicker(
      BuildContext context, String label, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final timeModel = Provider.of<AppDataProvider>(context, listen: false);
      if (isStartTime) {
        timeModel.updateStartTime(label, picked);
      } else {
        timeModel.updateEndTime(label, picked);
      }
    }
  }

  void _showTimeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          titlePadding: EdgeInsets.symmetric(vertical: 0),
          title: Container(
            decoration: BoxDecoration(
                color: AppColors.lightHeaderBlue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            width: double.infinity,
            height: 35,
            child: Center(
                child: Text('Qo\'riqlash vaqt oralig\'ini kiriting',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold))),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (_selectedItem2 == 'Harakat sezgi sensorlar bilan' ||
                    _selectedItem2 ==
                        'Harakat sezgi sensorlar va tashvish tugmasi bilan')
                  _buildTimePickerSection(
                      'Harakat sezgi sensorlar orqali', context),
                if (_selectedItem2 == 'Tashvish tugmasi bilan' ||
                    _selectedItem2 ==
                        'Harakat sezgi sensorlar va tashvish tugmasi bilan')
                  _buildTimePickerSection('Tashvish tugmasi orqali', context),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightButtonGreen),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Tanlash',
                      style: AppStyle.fontStyle
                          .copyWith(color: AppColors.lightHeaderColor))),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimePickerSection(String title, BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        _buildTimePickerRow('${title}_Ish kunlari', context),
        _buildTimePickerRow('${title}_Shanba Yakshanba kunlari', context),
        _buildTimePickerRow('${title}_Bayram kunlari', context),
      ],
    );
  }

  Widget _buildTimePickerRow(String label, BuildContext context) {
    final timeModel = Provider.of<AppDataProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(label.split('_').last, style: TextStyle(fontSize: 12)),
          ),
          Flexible(
            child: IconButton(
              icon: Icon(
                Icons.access_time,
                size: 20,
                color: AppColors.lightIconGuardColor,
              ),
              onPressed: () {
                _showTimePicker(context, '${label}_start', true);
              },
            ),
          ),
          Flexible(
            child: Text(
              timeModel.startTimes['${label}_start'] != null
                  ? DateFormat.Hm().format(DateTime(
                      0,
                      0,
                      0,
                      timeModel.startTimes['${label}_start']!.hour,
                      timeModel.startTimes['${label}_start']!.minute))
                  : '--:--',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Text(' - ', style: TextStyle(fontSize: 12)),
          Flexible(
            child: IconButton(
              icon: Icon(
                Icons.access_time,
                size: 20,
                color: AppColors.lightIconGuardColor,
              ),
              onPressed: () {
                _showTimePicker(context, '${label}_end', false);
              },
            ),
          ),
          Flexible(
            child: Text(
              timeModel.endTimes['${label}_end'] != null
                  ? DateFormat.Hm().format(DateTime(
                      0,
                      0,
                      0,
                      timeModel.endTimes['${label}_end']!.hour,
                      timeModel.endTimes['${label}_end']!.minute))
                  : '--:--',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MiniRedAppBar(),
        MiniRedTitle(title: 'Texnik qo\'riqlash markazlari orqali Qo\'riqlash'),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text(
                'Obyekt turi',
                style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _showModalForItem1(
                  context,
                  objectTypes, // Use the fetched object types
                  (selectedItem) {
                    setState(() {
                      _selectedItem1 = selectedItem;
                    });
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/images/3.svg',
                    height: 30.0,
                    width: 30.0,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(_selectedItem1 ?? 'Tanlang',
                        style: AppStyle.fontStyle),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: AppColors.lightIconGuardColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text(
                'Siz qanday qo\'riqlash vositalarini tanlaysiz',
                style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _showModalForItem2(
                  context,
                  [
                    'Harakat sezgi sensorlar bilan',
                    'Tashvish tugmasi bilan',
                    'Harakat sezgi sensorlar va tashvish tugmasi bilan'
                  ],
                  (selectedItem) {
                    setState(() {
                      _selectedItem2 = selectedItem;
                    });
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/images/1.svg',
                    height: 30.0,
                    width: 30.0,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(_selectedItem2 ?? 'Tanlang',
                        style: AppStyle.fontStyle),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: AppColors.lightIconGuardColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              Text(
                'Qo\'riqlash vaqt oralig\'ini kiriting',
                style: AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _showTimeModal(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    'assets/images/2.svg',
                    height: 30.0,
                    width: 30.0,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Vaqt oralig\'ini kiriting',
                        style: AppStyle.fontStyle),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: AppColors.lightIconGuardColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            backgroundColor: AppColors.lightButtonGreen,
          ),
          onPressed: () {
            final timeModel =
                Provider.of<AppDataProvider>(context, listen: false);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArizaTexnikObyekt(
                  obyektTuri: _selectedItem1,
                  qoriqlashVositasi: _selectedItem2,
                  qoriqlashVaqtlari: {
                    ...timeModel.startTimes, // Passing start times
                    ...timeModel.endTimes, // Passing end times
                  },
                ),
              ),
            );
          },
          child: Text(
            'Ariza berish',
            style:
                AppStyle.fontStyle.copyWith(color: AppColors.lightHeaderColor),
          ),
        ),
      ],
    );
  }
}
