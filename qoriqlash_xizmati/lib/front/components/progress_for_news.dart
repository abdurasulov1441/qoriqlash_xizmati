import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class ProgressForNews extends StatelessWidget {
  const ProgressForNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CardLoading(
              height: 150,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              margin: EdgeInsets.only(bottom: 10),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CardLoading(
              height: 50,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              margin: EdgeInsets.only(bottom: 10),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CardLoading(
              height: 100,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              margin: EdgeInsets.only(bottom: 10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CardLoading(
                  width: 100,
                  height: 50,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  margin: EdgeInsets.only(bottom: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
