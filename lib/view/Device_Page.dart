import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:app/view/Box_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../firebase_store/fire_base_auth.dart';
import 'Instruction_page.dart';
import 'Camera_page.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});
  static String routeName = '/Device';

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  Widget build(BuildContext context) {
    var obRecei = ModalRoute.of(context)!.settings.arguments;
    obRecei = Map<String, dynamic>.from(obRecei as Map);
    final info = obRecei['item'];
    final uid = obRecei['uid'];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff64abbf),
          title: Center(
            child: const Text(
              'DEVICE DETAILS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                print("camera");
                var _firAuth = FirAuth();

                int i = 0;
                final list = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePickerWidget()));
                setState(() {
                  if (list == null) {
                    return;
                  } else {
                    if (list.length <= 5) {
                      list.forEach((element) {
                        for (var box in info.boxs) {
                          if (box.medicines.length == 0) {
                            box.medicines.add(element);
                            break;
                          }
                        }
                      });
                    } else {
                      list.forEach((element) {
                        for (var box in info.boxs) {
                          if (box.medicines.length == 0 ||
                              // element.usage.checkEmpty() == 0 ||
                              (box.medicines.length >= 0 &&
                                  element.usage.checkEmpty() ==
                                      box.getMedicine().usage.checkEmpty())) {
                            //print(element.usage.Info());
                            box.medicines.add(element);
                            break;
                          }
                        }
                      });
                    }
                  }
                });
                _firAuth.updateBox(info, uid);
                if (list.length >= 1) {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyListPage(boxs: info.boxs)));
                }
                //   ;
              },
              child: Icon(Icons.camera_alt_outlined, color: Colors.white),
            )
          ]),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Expanded(
                  child: ListView.builder(
                itemCount: info.boxs.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = info.boxs[index];
                  final obSend = {"item": item, "uid": uid, "device": info.id};
                  return GestureDetector(
                      onTap: () {
                        // Handle the tap event here
                        Navigator.pushNamed(context, BoxPage.routeName,
                            arguments: obSend);
                      },
                      child: Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {},
                              icon: Icons.edit,
                              backgroundColor: Colors.blue,
                            ),
                          ]),
                          child: Card(
                            color: Color(0xff64abbf),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 4.0, // Add a drop shadow to the card
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Icon(
                                        // Boxicons.bx_archive,
                                        Icons.medical_services_outlined,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Box ' + item.id.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40.0,
                                              ),
                                            ),
                                            if (item.medicines.length > 0)
                                              Column(children: [
                                                Text(
                                                  'Total Medicines : ' +
                                                      item.medicines.length
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ])
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (item.medicines.length > 0)
                                    Text(
                                      'Morning    Afternoon     Evening\n' +
                                          '${item.medicines[0].usage.mor.getTime()}    ' +
                                          '${item.medicines[0].usage.noon.getTime()}     ' +
                                          '${item.medicines[0].usage.even.getTime()} ',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                ])),
                          )));
                },
              )),
            ],
          )),
    );
  }
}
