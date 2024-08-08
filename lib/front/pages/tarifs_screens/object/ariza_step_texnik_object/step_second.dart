import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Import intl package
import 'package:qoriqlash_xizmati/back/api/FormData.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class BuildStep2Page extends StatefulWidget {
  final FormData formData;
  final ValueChanged<FormData> onUpdateFormData;
  final String? motionWorkDaysStartTime;
  final String? motionWorkDaysEndTime;
  final String? motionWeekendStartTime;
  final String? motionWeekendEndTime;
  final String? motionHolidayStartTime;
  final String? motionHolidayEndTime;

  final String? alarmWorkDaysStartTime;
  final String? alarmWorkDaysEndTime;
  final String? alarmWeekendStartTime;
  final String? alarmWeekendEndTime;
  final String? alarmHolidayStartTime;
  final String? alarmHolidayEndTime;
  final String? selectedGuardType;

  const BuildStep2Page({
    Key? key,
    required this.formData,
    required this.onUpdateFormData,
    this.motionWorkDaysStartTime,
    this.motionWorkDaysEndTime,
    this.motionWeekendStartTime,
    this.motionWeekendEndTime,
    this.motionHolidayStartTime,
    this.motionHolidayEndTime,
    this.alarmWorkDaysStartTime,
    this.alarmWorkDaysEndTime,
    this.alarmWeekendStartTime,
    this.alarmWeekendEndTime,
    this.alarmHolidayStartTime,
    this.alarmHolidayEndTime,
    this.selectedGuardType,
  }) : super(key: key);

  @override
  _BuildStep2PageState createState() => _BuildStep2PageState();
}

class _BuildStep2PageState extends State<BuildStep2Page> {
  String bossName = "Loading...";
  String regionName = "Loading...";
  String formattedDate = "";

  @override
  void initState() {
    super.initState();
    _fetchBossName(widget.formData.regionId);
    _fetchRegionName(widget.formData.regionId);
    _formatCurrentDate();
  }

  void _formatCurrentDate() {
    final now = DateTime.now();
    final day = DateFormat('d').format(now);
    final month = _getMonthName(now.month);
    final year = DateFormat('y').format(now);
    setState(() {
      formattedDate = '«$day» $month $year yil';
    });
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'yanvar';
      case 2:
        return 'fevral';
      case 3:
        return 'mart';
      case 4:
        return 'aprel';
      case 5:
        return 'may';
      case 6:
        return 'iyun';
      case 7:
        return 'iyul';
      case 8:
        return 'avgust';
      case 9:
        return 'sentabr';
      case 10:
        return 'oktabr';
      case 11:
        return 'noyabr';
      case 12:
        return 'dekabr';
      default:
        return '';
    }
  }

  Future<void> _fetchBossName(String? regionId) async {
    if (regionId == null) {
      setState(() {
        bossName = "Region ID is not set";
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'http://10.100.9.145:7684/api/v1/ref/boss-name?region_id=$regionId'),
      );

      if (response.statusCode == 200) {
        final responseData = json
            .decode(utf8.decode(response.bodyBytes)); // Ensure UTF-8 decoding
        print('Response data: $responseData');

        setState(() {
          bossName = responseData['data'] ?? "No name available";
        });
      } else {
        print('Failed to load boss name. Status code: ${response.statusCode}');
        setState(() {
          bossName = "Error loading name";
        });
      }
    } catch (e) {
      print('Exception caught: $e');
      setState(() {
        bossName = "Error loading name";
      });
    }
  }

  Future<void> _fetchRegionName(String? regionId) async {
    if (regionId == null) {
      setState(() {
        regionName = "Region not set";
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://10.100.9.145:7684/api/v1/ref/regions'),
      );

      if (response.statusCode == 200) {
        final responseData = json
            .decode(utf8.decode(response.bodyBytes)); // Ensure UTF-8 decoding
        print('Regions data: $responseData');

        final region = responseData.firstWhere(
          (region) => region['id'].toString() == regionId,
          orElse: () => null,
        );

        setState(() {
          regionName = region?['name'] ?? "Region not found";
        });
      } else {
        print('Failed to load regions. Status code: ${response.statusCode}');
        setState(() {
          regionName = "Error loading regions";
        });
      }
    } catch (e) {
      print('Exception caught: $e');
      setState(() {
        regionName = "Error loading regions";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 219,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'O\'zbekiston Respublikasi Milliy Gvardiyasi ',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$regionName Qo\'riqlash boshqarmasi ',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' boshlig\'i',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${bossName}ga ',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '"${widget.formData.legalName} "',
                    style: AppStyle.fontStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Direktori: ${widget.formData.leaderName}',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Telefon: ${widget.formData.leaderPhone}',
                    style: AppStyle.fontStyle.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              maxLines: 3,
              '       Sizga, shuni ma’lum qilamizki ${widget.formData.address}da joylashgan tashkilotimiz Qo’riqlovi va xavfsizligini Ta’minlash maqsadida ',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (widget.selectedGuardType == '1' || widget.selectedGuardType == '3')
          Column(
            children: [
              Text(
                'Perimetr (Harakat sezgi sensorlari)',
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTimeRow('Ish kunlari', widget.motionWorkDaysStartTime,
                  widget.motionWorkDaysEndTime),
              _buildTimeRow('Shanba va Yakshanba kunlari',
                  widget.motionWeekendStartTime, widget.motionWeekendEndTime),
              _buildTimeRow('Bayram kunlari', widget.motionHolidayStartTime,
                  widget.motionHolidayEndTime),
            ],
          ),
        if (widget.selectedGuardType == '2' || widget.selectedGuardType == '3')
          Column(
            children: [
              Text(
                'Tashvish tugmasi',
                style: AppStyle.fontStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTimeRow('Ish kunlari', widget.alarmWorkDaysStartTime,
                  widget.alarmWorkDaysEndTime),
              _buildTimeRow('Shanba va Yakshanba kunlari',
                  widget.alarmWeekendStartTime, widget.alarmWeekendEndTime),
              _buildTimeRow('Bayram kunlari', widget.alarmHolidayStartTime,
                  widget.alarmHolidayEndTime),
            ],
          ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              maxLines: 3,
              'TQM qo’riqloviga ulab  shartnoma tuzishda amaliy yordam berishingizni so’raymiz. Qo’riqlov uchun oylik to’lovlarni kafolatlaymiz',
              style: AppStyle.fontStyle.copyWith(fontSize: 10),
            ),
          ),
        ),
        const SizedBox(height: 100),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  formattedDate,
                  style:
                      AppStyle.fontStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [Text('${widget.formData.legalName}')],
                ),
                Row(
                  children: [Text('Direktori: ${widget.formData.leaderName}')],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Imzolash'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildTimeRow(String label, String? startTime, String? endTime) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 10),
      Text(
        '$label: ${startTime ?? "--:--"} / ${endTime ?? "--:--"}',
        style: AppStyle.fontStyle.copyWith(fontSize: 10),
      ),
    ],
  );
}
