import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/numeric/pie.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/components/custom_appbar.dart';
import 'package:qoriqlash_xizmati/front/pages/pult_boshligi_pages/kelib_tushgan_arizalar_page.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class PultBoshligiHome extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PultBoshligiHome({super.key});

  @override
  Widget build(BuildContext context) {
    List<NumericData> numericDataList = [
      NumericData(domain: 1, measure: 3, color: Colors.grey[300]),
      NumericData(domain: 2, measure: 5, color: Colors.green[300]),
      NumericData(domain: 3, measure: 9, color: Colors.orange[300]),
      NumericData(domain: 4, measure: 6.5, color: Colors.red[300]),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: Drawer(
          child: Container(
            color: AppColors.customAppBarColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.customAppBarColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/set.png', // Путь к вашему изображению логотипа
                        height: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Qo\'riqlash xizmati',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.selectedIconColor,
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text('Bosh sahifa',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.assignment, color: Colors.white),
                  title: Text('Kelib tushgan ariza',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    pushScreenWithoutNavBar(
                        context, KelibTushganArizalarPage());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.description, color: Colors.white),
                  title: Text('AKT', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book, color: Colors.white),
                  title: Text('Dalolatnomalar',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cancel, color: Colors.white),
                  title: Text('Bekor bo\'lgan arizalar',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.uxuiColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Murojat turi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        value: 'Hammasi',
                        items: <String>['Hammasi', 'Option 1', 'Option 2']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      DropdownButton<String>(
                        value: 'Hammasi',
                        items: <String>['Hammasi', 'Option 1', 'Option 2']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartPieN(
                      data: numericDataList,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      LegendItem(
                          color: Colors.green[300]!,
                          text: 'Obyektni qo\'riqilovga topshirish'),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      LegendItem(
                          color: Colors.cyan[300]!,
                          text: 'Obyektni qo\'riqilovga topshirish'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
