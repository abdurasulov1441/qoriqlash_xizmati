import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/pult_boshligi_pages/bayonnoma_next_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class BayonnomaPultBoshligi extends StatefulWidget {
  @override
  _DropdownFormState createState() => _DropdownFormState();
}

class _DropdownFormState extends State<BayonnomaPultBoshligi> {
  String simCard = 'Uzmobile';
  String simCardPrice = '6 310 so\'m';
  String securityType = 'Harakat sezgi sensorlar';
  String doorSensor = 'Kiriting';
  String motionSensor = 'Kiriting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiniRedAppBar(),
              MiniRedTitle(title: 'Bayonnoma'),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Sim karta',
                              prefixIcon: Icon(
                                Icons.sim_card,
                                color: AppColors.lightIconGuardColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            value: simCard,
                            onChanged: (String? newValue) {
                              setState(() {
                                simCard = newValue!;
                              });
                            },
                            items: <String>[
                              'Uzmobile',
                              'Beeline',
                              'Ucell',
                              'UMS'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Sim karta narxi',
                              prefixIcon: Icon(
                                Icons.price_change,
                                color: AppColors.lightIconGuardColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            value: simCardPrice,
                            onChanged: (String? newValue) {
                              setState(() {
                                simCardPrice = newValue!;
                              });
                            },
                            items: <String>[
                              '6 310 so\'m',
                              '7 000 so\'m',
                              '8 500 so\'m'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Qo\'riqlash turini tanlang',
                        prefixIcon: Icon(
                          Icons.security,
                          color: AppColors.lightIconGuardColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      value: securityType,
                      onChanged: (String? newValue) {
                        setState(() {
                          securityType = newValue!;
                        });
                      },
                      items: <String>[
                        'Harakat sezgi sensorlar',
                        'Tashvish tugmasi orqali',
                        'Harakat sensorlari orqali'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Eshik datchikgi',
                              prefixIcon: Icon(
                                Icons.door_front_door,
                                color: AppColors.lightIconGuardColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            value: doorSensor,
                            onChanged: (String? newValue) {
                              setState(() {
                                doorSensor = newValue!;
                              });
                            },
                            items: <String>['Kiriting', 'Option 1', 'Option 2']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Harakat datchikgi',
                              prefixIcon: Icon(
                                Icons.motion_photos_on,
                                color: AppColors.lightIconGuardColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            value: motionSensor,
                            onChanged: (String? newValue) {
                              setState(() {
                                motionSensor = newValue!;
                              });
                            },
                            items: <String>['Kiriting', 'Option 1', 'Option 2']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BayonnomaNextPage()),
                  );
                },
                child: Text(
                  'Keyingisi',
                  style: AppStyle.fontStyle
                      .copyWith(color: AppColors.lightHeaderColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightIconGuardColor,
                  side: BorderSide(color: AppColors.lightIconGuardColor),
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
