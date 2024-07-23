import 'package:flutter/material.dart';

class SimpleForm extends StatefulWidget {
  @override
  _SimpleFormState createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  String? selectedPost;
  String? selectedEmployee;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Submission'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration:
                  const InputDecoration(labelText: "Post sonini tanlang"),
              value: selectedPost,
              onChanged: (newValue) {
                setState(() {
                  selectedPost = newValue;
                });
              },
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButtonFormField<String>(
              decoration:
                  const InputDecoration(labelText: "Xodim sonini tanlang"),
              value: selectedEmployee,
              onChanged: (newValue) {
                setState(() {
                  selectedEmployee = newValue;
                });
              },
              items: ['Employee 1', 'Employee 2', 'Employee 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButtonFormField<String>(
              decoration:
                  const InputDecoration(labelText: "Qo'riqlov vaqti tanlang"),
              value: selectedTime,
              onChanged: (newValue) {
                setState(() {
                  selectedTime = newValue;
                });
              },
              items: ['Time 1', 'Time 2', 'Time 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Ariza berish'),
              // style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
