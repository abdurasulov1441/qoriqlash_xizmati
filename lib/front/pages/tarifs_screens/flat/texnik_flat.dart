import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/ariza_texnik_object.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class TexnikFlat extends StatelessWidget {
  const TexnikFlat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [DropDownFlat()],
        ),
      ),
    );
  }
}

class DropDownFlat extends StatefulWidget {
  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropDownFlat> {
  String? _selectedItem1;
  String? _selectedItem2;
  String? _selectedRoom; // New variable for room selection

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
              child: Text('Yashash joyini tanlang',
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

  void _showRoomSelection(
      BuildContext context, List<String> rooms, Function(String) onSelect) {
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
                child: Text('Xonani sonini tanlang',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold))),
          ),
          content: Container(
            height: 200,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: rooms.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(rooms[index], style: AppStyle.fontStyle),
                  leading: Radio(
                    value: rooms[index],
                    groupValue: _selectedRoom,
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
                'Yashash joyini tanlang',
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
                  ['Ko\'p qavaqtli uy', 'Hovli'],
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
                'Qo’riqlash turini tanlang',
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
                'Xonani sonini tanlang', // Updated text for room selection
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
                _showRoomSelection(
                  context,
                  [
                    '1-xonali',
                    '2-xonali',
                    '3-xonali',
                    '4-xonali',
                    '5-xonali'
                  ], // Static room options
                  (selectedRoom) {
                    setState(() {
                      _selectedRoom = selectedRoom;
                    });
                  },
                );
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
                    child: Text(_selectedRoom ?? 'Tanlang',
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: AppColors.lightButtonGreen),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArizaTexnikObyekt()),
              );
            },
            child: Text('Ariza berish',
                style: AppStyle.fontStyle
                    .copyWith(color: AppColors.lightHeaderColor))),
      ],
    );
  }
}
