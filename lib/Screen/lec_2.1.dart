import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/Provider/lec_2.1_provider.dart';
import 'package:provider/provider.dart';

class Lec_2 extends StatelessWidget {
  const Lec_2({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<Lec2Provider>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text('Task 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: providerTrue.txtDatePickerController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      providerTrue.txtDatePickerController.text =
                      '${date.day}/${date.month}/${date.year}';
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Phone ringtone'),
                    actions: [
                      const Divider(),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              value: 'None',
                              groupValue: 'None',
                              onChanged: (value) {},
                              title: const Text('None'),
                            ),
                            RadioListTile(
                              value: false,
                              groupValue: 'Candy',
                              onChanged: (value) {},
                              title: const Text('Candy'),
                            ),
                            RadioListTile(
                              value: false,
                              groupValue: 'Crystal',
                              onChanged: (value) {},
                              title: const Text('Crystal'),
                            ),
                            RadioListTile(
                              value: false,
                              groupValue: 'Buzz',
                              onChanged: (value) {},
                              title: const Text('Buzz'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
              },
              child: const Text('Time Picker'),
            ),
            Expanded(
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {},
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text('Action Sheet'),
                    actions: List.generate(
                      3,
                          (index) => ListTile(
                        leading: Text('${index + 1}'),
                        title: Text('Task ${index + 1}'),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}