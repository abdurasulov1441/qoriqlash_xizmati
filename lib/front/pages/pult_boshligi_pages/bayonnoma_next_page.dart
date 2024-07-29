import 'package:flutter/material.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class BayonnomaNextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'BAYONNOMA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'O\'zbekiston Respublikasi Milliy gvardiyasi Qo\'riqlash bosh boshqarmasi Toshkent shahar Qo\'riqlash boshqarmasining obyekt (xonadon) da ko\'rsatilgan qo\'riqlash xizmati uchun tariflar asosida xizmat narxi belgilandi.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildRow('Obyekt (xonadon) egasining:',
                        'Raximov Voris Avazbek O\'g\'li'),
                    _buildRow('Manzil:',
                        'Mirzo Ulugbek tumani, Alisher Navoiy MFY, Shohsulton ko\'chasi, 9-uy, 8-xonadon'),
                    _buildRow('Telefon №:', '+998 (99) 786-25-81'),
                    _buildRow('TQM №:', '150011'),
                    SizedBox(height: 20),
                    _buildTable(),
                    SizedBox(height: 20),
                    Text(
                      'Izoh: "Ijozchi" xizmatlari uchun to\'lovlarga o\'zgartirishlar kiritish qonun hujjatlariga muvofiq ushbu xizmatlar turi va xizmat tarif tasdiqlangan hollarda qo\'yib chiqiladi. "Ijozchi" xizmat tariflari organining hajmida "Buyurtmachi"ni ogoh etadi. (xabardar qiladi).',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Imzolar:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildSignatureRow('IJROCHI:', 'BUYURTMACHI:'),
                    _buildSignatureRow(
                        'O\'zbekiston Respublikasi Milliy gvardiyasi',
                        'Mirzo Ulugbek tumani, Alisher Navoiy MFY,'),
                    _buildSignatureRow('Qo\'riqlash bosh boshqarmasi',
                        'Shohsulton ko\'chasi, 9-uy, 8-xonadon'),
                    _buildSignatureRow(
                        'Toshkent shahar Qo\'riqlash boshqarmasi',
                        'Raximov Voris Avazbek O\'g\'li'),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: [
        _buildTableRow('Qo\'riqlash turi', 'Asos', 'Buyurtmachining F.I.Sh',
            'Xizmat ko\'rsatishning bir oylik narxi (so\'m)', 'Izoh'),
        _buildTableRow(
            'TQM obyekt (xonadon) egasining o\'z xonadoni',
            'Shaxsiy mulkni qo\'riqlash shartnomasi',
            'Raximov Voris Avazbek O\'g\'li',
            '58 365 so\'m',
            ''),
        _buildTableRow('Sim karta', 'Shaxsiy mulkni qo\'riqlash shartnomasi',
            'Uzmobile', '6 310 so\'m', ''),
        _buildTableRow('Jami summa', 'Shaxsiy mulkni qo\'riqlash shartnomasi',
            '', '64 675 so\'m', ''),
      ],
    );
  }

  TableRow _buildTableRow(
      String col1, String col2, String col3, String col4, String col5) {
    return TableRow(
      children: [
        _buildTableCell(col1),
        _buildTableCell(col2),
        _buildTableCell(col3),
        _buildTableCell(col4),
        _buildTableCell(col5),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }

  Widget _buildSignatureRow(String label1, String label2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label1),
          Text(label2),
        ],
      ),
    );
  }
}
