import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Savol javoblar'),
            SizedBox(
              height: 30,
            ),
            FAQ(
              showDivider: false,
              collapsedIcon: Icon(Icons.add),
              ansStyle: AppStyle.fontStyle.copyWith(color: Colors.grey),
              question: "Shartnoma qanday tuziladi?",
              answer: data4,
              queStyle: AppStyle.fontStyle,
            ),
            FAQ(
                showDivider: false,
                collapsedIcon: Icon(Icons.add),
                ansStyle: AppStyle.fontStyle.copyWith(color: Colors.grey),
                queStyle: AppStyle.fontStyle,
                question: "Sizlarda qanday qo’riqlash ta’riflari bor?",
                answer: data4),
            FAQ(
                showDivider: false,
                collapsedIcon: Icon(Icons.add),
                ansStyle: AppStyle.fontStyle.copyWith(color: Colors.grey),
                queStyle: AppStyle.fontStyle,
                question: "Qo’riqlash xizmatining vazifasi nima?",
                answer: data4),
            FAQ(
                showDivider: false,
                collapsedIcon: Icon(Icons.add),
                ansStyle: AppStyle.fontStyle.copyWith(color: Colors.grey),
                queStyle: AppStyle.fontStyle,
                question:
                    "Men nega sizlarga  xonadonimni yoki obyektimni qo’riqlovga topshirishim kerak?",
                answer: data4),
          ],
        ),
      ),
    );
  }
}

String data4 =
    'O‘zbekiston Respublikasi Milliy gvardiyasining shartnoma asosida davlat va xo‘jalik boshqaruvi organlarining, mahalliy davlat hokimiyati organlarining, shuningdek jismoniy va yuridik shaxslarning obyektlarini qo‘riqlash uchun tuziladigan tarkibiy bo‘linmasi tomonidan amalga oshiriladigan qo‘riqlash faoliyatining turi;';
