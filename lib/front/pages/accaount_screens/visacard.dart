import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
// import 'package:flutter_flip_card/flipcard/flip_card.dart';
// import 'package:flutter_flip_card/flutter_flip_card.dart';

// import 'package:u_credit_card/u_credit_card.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: AppColors.lightIconGuardColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: AppColors.lightHeaderColor,
        ),
      ),
      body: const Column(
        children: [
          MiniRedAppBar(),
          MiniRedTitle(title: 'Mening kartalarim'),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CardList(),
          ),
        ],
      ),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                      width: 20,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container();
                })));
  }
}
