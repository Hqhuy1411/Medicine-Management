import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:app/model/Box.dart';
import 'package:app/model/Device.dart';
import 'package:app/model/Medicine.dart';
import 'package:app/model/TimeSlot.dart';
import 'package:app/model/Usage.dart';
import 'package:app/view/Box_Page.dart';
import 'package:app/view/abc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase_store/fire_base_auth.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});
  static String routeName = '/Device';

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  String _imagepath = '';
  DateTime dateS = DateTime(2023, 1, 1);
  DateTime dateC = DateTime(2023, 1, 1);
  DateTime dateT = DateTime(2023, 1, 1);
  final ImagePicker imgpicker = ImagePicker();
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
                          Text('Thiet bi so ' + info.id.toString(),
                              style: Theme.of(context).textTheme.headline6),
                          Text('Device Info ' + info.description,
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
              child: info.boxs.length != 0
                  ? ListView.builder(
                      itemCount: info.boxs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = info.boxs[index];
                        final obSend = {
                          "item": item,
                          "uid": uid,
                          "device": info.id
                        };
                        return GestureDetector(
                            onTap: () {
                              // Handle the tap event here
                              Navigator.pushNamed(context, BoxPage.routeName,
                                  arguments: obSend);
                            },
                            child: Slidable(
                                endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showEditTime(item, info.id, uid);
                                        },
                                        icon: Icons.edit,
                                        backgroundColor: Colors.blue,
                                      ),
                                    ]),
                                child: Card(
                                  elevation:
                                      4.0, // Add a drop shadow to the card
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.gif_box),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Box so :' +
                                                      item.id.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                              Text(
                                                  'Total Medicines : ' +
                                                      item.medicines.length
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                              Text(
                                                'Sang : ${item.medicines[0].usage.mor.getTime()}' +
                                                    ' Chieu : ${item.medicines[0].usage.noon.getTime()}' +
                                                    ' Toi : ${item.medicines[0].usage.even.getTime()}',
                                              ),
                                              for (var medicine
                                                  in item.medicines)
                                                Text(medicine.Info())
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )));
                      },
                    )
                  : Center(
                      child: _imagepath == ""
                          ? Text('No image selected.')
                          : Stack(
                              children: [
                                Image.file(File(_imagepath)),
                                Positioned(
                                  bottom: 0,
                                  left: 150,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Send'),
                                  ),
                                ),
                              ],
                            ),
                    ),
            ),
          ],
        ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "tag0",
              onPressed: (() {
                _displayTextInputDialog(context, info, uid);
              }),
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: "tag1",
              onPressed: (() async {
                var _firAuth = FirAuth();

                List<Box> boxs = [];
                int i = 0;
                final list = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => App()));

                if (list != null) {
                  list.forEach((element) {
                    boxs.add(Box(id: ++i, medicines: [element]));
                    print(element.usage.even.time);
                    print(element.toJson());
                  });
                }

                setState(() {
                  info.boxs = boxs;
                });
                for (var box in boxs) {
                  _firAuth.addMultiBox(info, uid);
                }
              }),
              child: Icon(Icons.restart_alt_rounded),
            ),
            FloatingActionButton(
              heroTag: "tag2",
              onPressed: () async {
                try {
                  var pickedFile =
                      await imgpicker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _imagepath = pickedFile.path;
                    });
                  } else {
                    print("No image is selected.");
                  }
                } catch (e) {
                  print("error while picking image.");
                }
                print("camera");
              },
              child: Icon(Icons.camera),
            ),
          ],
        ));
  }

  Future<void> showEditTime(Box box, int device, String uid) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: StatefulBuilder(builder: (context, setState) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: Text(
                                    '${box.getMedicine().usage.mor.getTime()}'),
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
                                    box.getMedicine().usage.mor.time = newtime;
                                  });
                                }),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: Text(
                                    '${box.getMedicine().usage.noon.getTime()}'),
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
                                    box.getMedicine().usage.noon.time = newtime;
                                  });
                                }),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                child: Text(
                                    '${box.getMedicine().usage.even.getTime()}'),
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
                                    box.getMedicine().usage.even.time = newtime;
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
                  setState(() {
                    box.medicines.forEach((e) => {});
                  });
                  _firAuth.UpdateMedicine(box, device, uid);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Device device, String uid) async {
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

                  setState(() {
                    Box box = Box(medicines: [medicine]);
                    box.id = device.boxs.length + 1;
                    device.boxs.add(box);
                    _firAuth.addBox(box, device.id!, uid);
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
