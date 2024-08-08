import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:qoriqlash_xizmati/back/api/FormData.dart';
import 'dart:convert';

import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class BuildStep1Page extends StatefulWidget {
  final FormData formData;
  final ValueChanged<FormData> onUpdateFormData;

  const BuildStep1Page({
    Key? key,
    required this.formData,
    required this.onUpdateFormData,
  }) : super(key: key);

  @override
  _BuildStep1PageState createState() => _BuildStep1PageState();
}

class _BuildStep1PageState extends State<BuildStep1Page> {
  List<dynamic> regions = [];
  List<dynamic> districts = [];
  String? selectedRegion;
  String? selectedDistrict;
  late TextEditingController addressController;
  late TextEditingController leaderNameController;
  late TextEditingController leaderPhoneController;
  late TextEditingController legalNameController;

  @override
  void initState() {
    super.initState();
    fetchRegions();
    selectedRegion = widget.formData.regionId;
    selectedDistrict = widget.formData.districtId;
    addressController = TextEditingController(text: widget.formData.address);
    leaderNameController =
        TextEditingController(text: widget.formData.leaderName);
    leaderPhoneController =
        TextEditingController(text: widget.formData.leaderPhone);
    legalNameController =
        TextEditingController(text: widget.formData.legalName);

    if (selectedRegion != null) {
      fetchDistricts(selectedRegion!);
    }
  }

  Future<void> fetchRegions() async {
    final response = await http
        .get(Uri.parse('http://10.100.9.145:7684/api/v1/ref/regions'));

    if (response.statusCode == 200) {
      setState(() {
        regions = json.decode(utf8.decode(response.bodyBytes));
        if (selectedRegion == null) {
          selectedRegion =
              regions.isNotEmpty ? regions[0]['id'].toString() : null;
          if (selectedRegion != null) {
            fetchDistricts(selectedRegion!);
          }
        }
      });
    } else {
      // Handle the error
      print('Failed to load regions');
    }
  }

  Future<void> fetchDistricts(String regionId) async {
    final response = await http.get(Uri.parse(
        'http://10.100.9.145:7684/api/v1/ref/distcities?region_id=$regionId'));

    if (response.statusCode == 200) {
      setState(() {
        districts = json.decode(utf8.decode(response.bodyBytes));
        selectedDistrict = widget.formData.districtId ??
            (districts.isNotEmpty ? districts[0]['id'].toString() : null);
      });
    } else {
      // Handle the error
      print('Failed to load districts');
    }
  }

  void _updateFormData() {
    widget.onUpdateFormData(FormData(
      regionId: selectedRegion,
      districtId: selectedDistrict,
      address: addressController.text,
      leaderName: leaderNameController.text,
      leaderPhone: leaderPhoneController.text,
      legalName: legalNameController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Hududni tanlang',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedRegion,
                  decoration: InputDecoration(
                    label: SvgPicture.asset(
                      'assets/images/location.svg',
                      width: 40,
                      height: 40,
                    ),
                    filled: true,
                    fillColor: AppColors.fillColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                  ),
                  items: regions
                      .map((region) => DropdownMenuItem(
                            value: region['id'].toString(),
                            child: Text(region['name']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value;
                      selectedDistrict = null;
                      fetchDistricts(selectedRegion!);
                      _updateFormData();
                    });
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Tumanni tanlang',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedDistrict,
                  decoration: InputDecoration(
                    label: SvgPicture.asset(
                      'assets/images/location.svg',
                      width: 40,
                      height: 40,
                    ),
                    filled: true,
                    fillColor: AppColors.fillColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                  ),
                  items: districts
                      .map((district) => DropdownMenuItem(
                            value: district['id'].toString(),
                            child: Text(district['name']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDistrict = value;
                      _updateFormData();
                    });
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Manzil',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    label: SvgPicture.asset(
                      'assets/images/location.svg',
                      width: 40,
                      height: 40,
                    ),
                    filled: true,
                    fillColor: AppColors.fillColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                  ),
                  onChanged: (value) {
                    _updateFormData();
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Obyekt rahbarining F.I.SH',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: leaderNameController,
                  decoration: InputDecoration(
                    label: SvgPicture.asset(
                      'assets/images/person1.svg',
                      width: 40,
                      height: 40,
                    ),
                    filled: true,
                    fillColor: AppColors.fillColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                  ),
                  onChanged: (value) {
                    _updateFormData();
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Obyekt rahbarining telefon raqami',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: leaderPhoneController,
                  decoration: InputDecoration(
                    label: SvgPicture.asset(
                      'assets/images/phone.svg',
                      width: 40,
                      height: 40,
                    ),
                    filled: true,
                    fillColor: AppColors.fillColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                  ),
                  onChanged: (value) {
                    _updateFormData();
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Obyektning yuridik nomi',
                    style: AppStyle.fontStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: legalNameController,
                  decoration: InputDecoration(
                    label: SvgPicture.asset(
                      'assets/images/buildings.svg',
                      width: 40,
                      height: 40,
                    ),
                    filled: true,
                    fillColor: AppColors.fillColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          width: 0, color: AppColors.lightHeaderColor),
                    ),
                  ),
                  onChanged: (value) {
                    _updateFormData();
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
