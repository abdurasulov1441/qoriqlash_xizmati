import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/components/custom_appbar.dart';
import 'package:qoriqlash_xizmati/front/pages/pult_boshligi_pages/pult_boshligi_home.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class KelibTushganArizalarPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  KelibTushganArizalarPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text('Bosh sahifa',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      pushScreenWithoutNavBar(context, PultBoshligiHome());
                    },
                  ),
                ),
                Container(
                  color: AppColors.selectedIconColor,
                  child: ListTile(
                    leading: Icon(Icons.assignment, color: Colors.white),
                    title: Text('Kelib tushgan ariza',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
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
        body: Container(
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.uxuiColor,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Kelib tushgan arizalar',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child:
                      SizedBox(width: double.infinity, child: CustomListView()))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.brown,
                    size: 15,
                  ),
                  Text('№12651', style: TextStyle(color: Colors.brown)),
                  SizedBox(width: 8),
                  Text('Rahimov Voris', style: TextStyle(color: Colors.brown)),
                  SizedBox(width: 8),
                  Icon(
                    Icons.phone,
                    color: Colors.brown,
                    size: 15,
                  ),
                  SizedBox(width: 8),
                  Text('+998 (99) 786 25 51',
                      style: TextStyle(color: Colors.brown)),
                  SizedBox(width: 8),
                  Icon(
                    Icons.download,
                    color: Colors.brown,
                    size: 15,
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.brown,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
