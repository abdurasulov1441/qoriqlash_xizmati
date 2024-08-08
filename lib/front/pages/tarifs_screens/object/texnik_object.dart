import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
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
  List<String> objectTypes = [];
  List<Map<String, dynamic>> guardTypes = [];
  List<Map<String, dynamic>> guardTimes = [];

  // Variables to hold selected times for sensors
  String? _motionWorkDaysStartTime;
  String? _motionWorkDaysEndTime;
  String? _motionWeekendStartTime;
  String? _motionWeekendEndTime;
  String? _motionHolidayStartTime;
  String? _motionHolidayEndTime;

  String? _alarmWorkDaysStartTime;
  String? _alarmWorkDaysEndTime;
  String? _alarmWeekendStartTime;
  String? _alarmWeekendEndTime;
  String? _alarmHolidayStartTime;
  String? _alarmHolidayEndTime;

  @override
  void initState() {
    super.initState();
    fetchObjectTypes();
    fetchGuardTypes();
    fetchGuardTimes();
  }

  Future<void> fetchObjectTypes() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.100.9.145:7684/api/v1/ref/object-types?parent_id=1'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
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

  Future<void> fetchGuardTypes() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.100.9.145:7684/api/v1/ref/guard-types?type_id=1'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          guardTypes = data.map((item) {
            return {'id': item['id'], 'name': item['name']};
          }).toList();
        });
      } else {
        print('Failed to load guard types');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchGuardTimes() async {
    try {
      final response = await http
          .get(Uri.parse('http://10.100.9.145:7684/api/v1/ref/guard-time'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          guardTimes = data['data']
              .map<Map<String, dynamic>>((item) => {
                    'id': item['id'],
                    'value': item['value'],
                    'name': item['name']
                  })
              .toList();
        });
      } else {
        print('Failed to load guard times');
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

  void _showModalForItem2(BuildContext context,
      List<Map<String, dynamic>> items, Function(String) onSelect) {
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
                  title: Text(items[index]['name'], style: AppStyle.fontStyle),
                  leading: Radio(
                    value: items[index]['id'].toString(),
                    groupValue: _selectedItem2,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedItem2 = value;
                        print('Selected Guard Type Updated: $_selectedItem2');
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

  void _showTimeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: Text('Vaqtni tanlang', style: AppStyle.fontStyle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedItem2 == '1' || _selectedItem2 == '3')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Датчик движения',
                            style: AppStyle.fontStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          _buildTimeDropdown(
                            'Ish kunlari',
                            guardTimes,
                            _motionWorkDaysStartTime,
                            _motionWorkDaysEndTime,
                            (start, end) {
                              setState(() {
                                _motionWorkDaysStartTime = start;
                                _motionWorkDaysEndTime = end;
                              });
                            },
                          ),
                          _buildTimeDropdown(
                            'Shanba va yakshanba',
                            guardTimes,
                            _motionWeekendStartTime,
                            _motionWeekendEndTime,
                            (start, end) {
                              setState(() {
                                _motionWeekendStartTime = start;
                                _motionWeekendEndTime = end;
                              });
                            },
                          ),
                          _buildTimeDropdown(
                            'Dam olish kunlari',
                            guardTimes,
                            _motionHolidayStartTime,
                            _motionHolidayEndTime,
                            (start, end) {
                              setState(() {
                                _motionHolidayStartTime = start;
                                _motionHolidayEndTime = end;
                              });
                            },
                          ),
                        ],
                      ),
                    if (_selectedItem2 == '2' || _selectedItem2 == '3')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Тревожная кнопка',
                            style: AppStyle.fontStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          _buildTimeDropdown(
                            'Ish kunlari',
                            guardTimes,
                            _alarmWorkDaysStartTime,
                            _alarmWorkDaysEndTime,
                            (start, end) {
                              setState(() {
                                _alarmWorkDaysStartTime = start;
                                _alarmWorkDaysEndTime = end;
                              });
                            },
                          ),
                          _buildTimeDropdown(
                            'Shanba va yakshanba',
                            guardTimes,
                            _alarmWeekendStartTime,
                            _alarmWeekendEndTime,
                            (start, end) {
                              setState(() {
                                _alarmWeekendStartTime = start;
                                _alarmWeekendEndTime = end;
                              });
                            },
                          ),
                          _buildTimeDropdown(
                            'Dam olish kunlari',
                            guardTimes,
                            _alarmHolidayStartTime,
                            _alarmHolidayEndTime,
                            (start, end) {
                              setState(() {
                                _alarmHolidayStartTime = start;
                                _alarmHolidayEndTime = end;
                              });
                            },
                          ),
                        ],
                      ),
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
                            .copyWith(color: AppColors.lightHeaderColor)),
                  ),
                ),
                if (!_allTimePairsSelected())
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Iltimos, har bir vaqt juftligini tanlang.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  bool _allTimePairsSelected() {
    // Check if all time pairs have both start and end times selected
    return _isTimePairValid(_motionWorkDaysStartTime, _motionWorkDaysEndTime) &&
        _isTimePairValid(_motionWeekendStartTime, _motionWeekendEndTime) &&
        _isTimePairValid(_motionHolidayStartTime, _motionHolidayEndTime) &&
        _isTimePairValid(_alarmWorkDaysStartTime, _alarmWorkDaysEndTime) &&
        _isTimePairValid(_alarmWeekendStartTime, _alarmWeekendEndTime) &&
        _isTimePairValid(_alarmHolidayStartTime, _alarmHolidayEndTime);
  }

  bool _isTimePairValid(String? startTime, String? endTime) {
    // Only return true if both start and end times are selected
    return (startTime == null && endTime == null) ||
        (startTime != null && endTime != null);
  }

  Widget _buildTimeDropdown(
    String labelText,
    List<Map<String, dynamic>> items,
    String? startTime,
    String? endTime,
    Function(String?, String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: AppStyle.fontStyle),
          Row(
            children: [
              DropdownButton<String>(
                value: startTime,
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item['name'],
                          child: Text(item['name']),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    onChanged(value, endTime);
                  });
                },
                hint: Text(startTime ?? '--:--', style: AppStyle.fontStyle),
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: endTime,
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item['name'],
                          child: Text(item['name']),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    onChanged(startTime, value);
                  });
                },
                hint: Text(endTime ?? '--:--', style: AppStyle.fontStyle),
              ),
            ],
          ),
          if (!_isTimePairValid(startTime, endTime))
            Text(
              'Iltimos, ikkala vaqtni tanlang.',
              style: TextStyle(color: Colors.red),
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
        SizedBox(height: 20),
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
                  objectTypes,
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
                  guardTypes,
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
                    child: Text(
                      guardTypes
                          .firstWhere(
                              (item) => item['id'].toString() == _selectedItem2,
                              orElse: () => {'name': 'Tanlang'})['name']
                          .toString(),
                      style: AppStyle.fontStyle,
                    ),
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
                'Vaqtni sozlash',
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
                _showTimeSelectionDialog(context);
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
                    child: Text(
                      'Tanlang', // Display selected time information if needed
                      style: AppStyle.fontStyle,
                    ),
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
            print('Navigating with Guard Type: $_selectedItem2');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArizaTexnikObyekt(
                  selectedObjectType: _selectedItem1,
                  selectedGuardType: _selectedItem2, // Pass selectedGuardType
                  motionWorkDaysStartTime: _motionWorkDaysStartTime,
                  motionWorkDaysEndTime: _motionWorkDaysEndTime,
                  motionWeekendStartTime: _motionWeekendStartTime,
                  motionWeekendEndTime: _motionWeekendEndTime,
                  motionHolidayStartTime: _motionHolidayStartTime,
                  motionHolidayEndTime: _motionHolidayEndTime,
                  alarmWorkDaysStartTime: _alarmWorkDaysStartTime,
                  alarmWorkDaysEndTime: _alarmWorkDaysEndTime,
                  alarmWeekendStartTime: _alarmWeekendStartTime,
                  alarmWeekendEndTime: _alarmWeekendEndTime,
                  alarmHolidayStartTime: _alarmHolidayStartTime,
                  alarmHolidayEndTime: _alarmHolidayEndTime,
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
