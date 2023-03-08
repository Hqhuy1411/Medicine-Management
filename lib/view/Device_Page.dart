import 'package:app/model/Box.dart';
import 'package:app/model/Device.dart';
import 'package:app/model/Medicine.dart';
import 'package:app/model/TimeSlot.dart';
import 'package:app/model/Usage.dart';
import 'package:app/view/Box_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_store/fire_base_auth.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});
  static String routeName = '/Device';

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  TextEditingController nameMedicine = new TextEditingController();
  TextEditingController descripMedicine = new TextEditingController();
  TextEditingController quantityMedicine = new TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    var obRecei = ModalRoute.of(context)!.settings.arguments;
    obRecei = Map<String, dynamic>.from(obRecei as Map);
    final info = obRecei['item'];
    final uid = obRecei['uid'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Box'),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.devices),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Device Name' + info.name,
                            style: Theme.of(context).textTheme.headline6),
                        Text('Device Info',
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: info.boxs.length,
              itemBuilder: (BuildContext context, int index) {
                final item = info.boxs[index];
                final obSend = {"item": item, "uid": uid, "device": info.name};
                return GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                      Navigator.pushNamed(context, BoxPage.routeName,
                          arguments: obSend);
                    },
                    child: Card(
                      elevation: 4.0, // Add a drop shadow to the card
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.devices),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Box Name:' + item.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Text('Box Description ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (() {
        _displayTextInputDialog(context, info);
      })),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Device device) async {
    DateTime dateS = DateTime(2023, 1, 1);
    DateTime dateC = DateTime(2023, 1, 1);
    DateTime dateT = DateTime(2023, 1, 1);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: StatefulBuilder(builder: (context, setState) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      child: Column(
                    children: <Widget>[
                      TextFormField(
                        // ignore: prefer_const_constructors
                        controller: nameMedicine,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        // ignore: prefer_const_constructors
                        controller: descripMedicine,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Description',
                          icon: const Icon(Icons.email),
                        ),
                      ),
                      TextFormField(
                        // ignore: prefer_const_constructors
                        controller: quantityMedicine,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          icon: Icon(Icons.message),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: quantityMedicine,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Sang',
                                icon: Icon(Icons.message),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: dateS.hour == 0
                                    ? Text("Select Time")
                                    : Text('${dateS.hour}' ': ${dateS.minute}'),
                                onPressed: () async {
                                  final time = await pickTime();
                                  if (time == null) return;
                                  final newtime = DateTime(
                                      dateS.year,
                                      dateS.month,
                                      dateS.day,
                                      time.hour,
                                      time.minute);
                                  setState(() {
                                    dateS = newtime;
                                  });
                                }),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: quantityMedicine,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Trua',
                                icon: Icon(Icons.message),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: dateC.hour == 0
                                    ? Text("Select Time")
                                    : Text('${dateC.hour}' ': ${dateC.minute}'),
                                onPressed: () async {
                                  final time = await pickTime();
                                  if (time == null) return;
                                  final newtime = DateTime(
                                      dateC.year,
                                      dateC.month,
                                      dateC.day,
                                      time.hour,
                                      time.minute);
                                  setState(() {
                                    dateC = newtime;
                                  });
                                }),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: quantityMedicine,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Toi',
                                icon: Icon(Icons.message),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: dateT.hour == 0
                                    ? Text("Select Time")
                                    : Text('${dateT.hour}' ': ${dateT.minute}'),
                                onPressed: () async {
                                  final time = await pickTime();
                                  if (time == null) return;
                                  final newtime = DateTime(
                                      dateT.year,
                                      dateT.month,
                                      dateT.day,
                                      time.hour,
                                      time.minute);
                                  setState(() {
                                    dateT = newtime;
                                  });
                                }),
                          )
                        ],
                      )
                    ],
                  )),
                ),
              );
            }),
            actions: <Widget>[
              ElevatedButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  var _firAuth = FirAuth();
                  Medicine medicine = Medicine(
                      name: nameMedicine.text,
                      description: descripMedicine.text,
                      quantity: int.parse(quantityMedicine.text),
                      usage: Usage(
                          mor: TimeSlot(quantity: 1, time: dateS),
                          noon: TimeSlot(quantity: 2, time: dateC),
                          even: TimeSlot(quantity: 3, time: dateT)));

                  _firAuth.AddMedicine3(medicine, "Thiet bi so 2",
                      "8IXddhgOE7PVc96mE7Q1jMkVqqA3");
                  setState(() {
                    device.boxs.add(Box(name: "name", medicines: [medicine]));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context, initialTime: TimeOfDay(hour: 7, minute: 0));
}
