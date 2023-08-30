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
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

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
  String _imagepath = '';
  DateTime dateS = DateTime(2023, 1, 1);
  DateTime dateC = DateTime(2023, 1, 1);
  DateTime dateT = DateTime(2023, 1, 1);
  // final ImagePicker imgpicker = ImagePicker();
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
            backgroundColor: Color(0xff64abbf),
            title: Center(
              child: Text(
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
                  // if (list != null) {
                  //   list.forEach((element) {
                  //     boxs.add(Box(id: ++i, medicines: [element]));
                  //     print(element.usage.even.time);
                  //     print(element.toJson());
                  //   });
                  // }
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
                  // setState(() {
                  //   info.boxs = boxs;
                  // });
                  // for (var box in boxs) {
                  //   _firAuth.addMultiBox(info, uid);
                  // }
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
            ]
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
            //     itemBuilder: (context) {
            //       return [
            //         PopupMenuItem<int>(
            //             value: 0,
            //             child: ListTile(
            //                 leading: Icon(
            //                   Icons.camera_alt_outlined,
            //                   color: Color(0xff64abbf),
            //                 ),
            //                 title: Text('Camera'),
            //                 onTap: () async {
            //                   // Handle save action
            //                   print("camera");
            //                   var _firAuth = FirAuth();

            //                   int i = 0;
            //                   final list = await Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => ImagePickerWidget()));
            //                   // if (list != null) {
            //                   //   list.forEach((element) {
            //                   //     boxs.add(Box(id: ++i, medicines: [element]));
            //                   //     print(element.usage.even.time);
            //                   //     print(element.toJson());
            //                   //   });
            //                   // }
            //                   setState(() {
            //                     if (list == null) {
            //                       return;
            //                     } else {
            //                       if (list.length <= 5) {
            //                         list.forEach((element) {
            //                           for (var box in info.boxs) {
            //                             if (box.medicines.length == 0) {
            //                               box.medicines.add(element);
            //                               break;
            //                             }
            //                           }
            //                         });
            //                       } else {
            //                         list.forEach((element) {
            //                           for (var box in info.boxs) {
            //                             if (box.medicines.length == 0 ||
            //                                 // element.usage.checkEmpty() == 0 ||
            //                                 (box.medicines.length >= 0 &&
            //                                     element.usage.checkEmpty() ==
            //                                         box
            //                                             .getMedicine()
            //                                             .usage
            //                                             .checkEmpty())) {
            //                               //print(element.usage.Info());
            //                               box.medicines.add(element);
            //                               break;
            //                             }
            //                           }
            //                         });
            //                       }
            //                     }
            //                   });
            //                   // setState(() {
            //                   //   info.boxs = boxs;
            //                   // });
            //                   // for (var box in boxs) {
            //                   //   _firAuth.addMultiBox(info, uid);
            //                   // }
            //                   _firAuth.updateBox(info, uid);
            //                   if (list.length >= 1) {
            //                     await Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) =>
            //                                 MyListPage(boxs: info.boxs)));
            //                   }
            //                   //   ;
            //                 })),
            //         // PopupMenuItem<int>(
            //         //     value: 1,
            //         //     child: ListTile(
            //         //       leading: Icon(
            //         //         Icons.refresh_outlined,
            //         //         color: Color(0xff64abbf),
            //         //       ),
            //         //       title: Text('Reset'),
            //         //       onTap: () {
            //         //         // Handle save action

            //         //         // Navigator.push(
            //         //         //     context,
            //         //         //     MaterialPageRoute(
            //         //         //         builder: (context) => CameraScreen()));
            //         //         // print("Reset");
            //         //         // try {
            //         //         //   var pickedFile = await imgpicker.pickImage(
            //         //         //       source: ImageSource.camera);
            //         //         //   if (pickedFile != null) {
            //         //         //     setState(() {
            //         //         //       _imagepath = pickedFile.path;
            //         //         //     });
            //         //         //   } else {
            //         //         //     print("No image is selected.");
            //         //         //   }
            //         //         // } catch (e) {
            //         //         //   print("error while picking image.");
            //         //         // }

            //         //         //instruction(context);
            //         //       },
            //         //     )),
            //       ];
            //     },
            //   ),
            // ],
            ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //     Container(
                //       width: 340,
                //       height: 50,
                //       color: Color(0xff64abbf),
                //       margin: EdgeInsets.only(top: 30, bottom: 40, left: 10, right: 10),
                //       child: Stack(
                //         children: [
                //           Positioned(
                //             top:
                //                 5, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                //             left:
                //                 5, // set vị trí đứng từ phải qua, dựa vào giá trị x
                //             child: IconButton(
                //               icon: Icon(
                //                 Icons.arrow_back_outlined,
                //                 color: Color(0xFFFFFFFF),
                //               ),
                //               onPressed: () {
                //                 // Navigator.popUntil(context, ModalRoute.withName('/'));
                //                 Navigator.pop(context);
                //               },
                //             ),
                //           ),

                //           Positioned(
                //             child: Center(
                //               child: Text(
                //                 'SMART MEDICINE BOX',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 15.0,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                // ),
                Card(
                    color: Color(0xff64abbf),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Boxicons.bx_archive,
                              size: 70, color: Colors.white),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('DEVICE ' + info.id.toString(),
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white)),
                                Text(
                                    'Patient:       ' +
                                        info.patient.fullname
                                            .toUpperCase()
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text('Info:       ' + info.description,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Row(
                //       children: [
                //         Icon(Boxicons.bx_package),
                //         SizedBox(width: 16.0),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text('DEVICE ' + info.id.toString(),
                //                   style: Theme.of(context).textTheme.headline6),
                //               Text('Description: ' + info.description,
                //                   style: Theme.of(context).textTheme.subtitle1),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 16.0),
                Expanded(
                    child: ListView.builder(
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
                            endActionPane:
                                ActionPane(motion: StretchMotion(), children: [
                              SlidableAction(
                                onPressed: (context) {
                                  if (item.medicines.length > 0) {
                                    showEditTime(item, info.id, uid);
                                  }
                                },
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

                                                  // for (var medicine
                                                  //     in item.medicines)
                                                  //   Text(medicine.Info())
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
                                    // Text(
                                    //   'Sang : ${item.medicines[0].usage.mor.getTime()}' +
                                    //       ' Chieu : ${item.medicines[0].usage.noon.getTime()}' +
                                    //       ' Toi : ${item.medicines[0].usage.even.getTime()}',
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 15.0,
                                    //   ),
                                    // ),
                                  ])),
                            )));
                  },
                )),
                SizedBox(
                  height: 20,
                ),
                // Expanded(
                //   child: _imagepath == ""
                //       ? Text('No image selected.')
                //       : Stack(
                //           children: [
                //             Image.file(File(_imagepath)),
                //             Positioned(
                //               bottom: 0,
                //               left: 100,
                //               child: ElevatedButton(
                //                 onPressed: () {},
                //                 child: Text('Send'),
                //               ),
                //             ),
                //           ],
                //         ),
                // )
              ],
            )),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // FloatingActionButton(
            //   heroTag: "tag0",
            //   onPressed: (() {
            //     _displayTextInputDialog(context, info, uid);
            //   }),
            //   child: Icon(Icons.add),
            // ),
            // FloatingActionButton(
            //   heroTag: "tag1",
            //   onPressed: (() async {
            //     var _firAuth = FirAuth();

            //     List<Box> boxs = [];
            //     int i = 0;
            //     final list = await Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => App()));

            //     // if (list != null) {
            //     //   list.forEach((element) {
            //     //     boxs.add(Box(id: ++i, medicines: [element]));
            //     //     print(element.usage.even.time);
            //     //     print(element.toJson());
            //     //   });
            //     // }
            //     setState(() {
            //       if (list == null) {
            //         return;
            //       } else {
            //         list.forEach((element) {
            //           for (var box in info.boxs) {
            //             if (box.medicines.length == 0) {
            //               box.medicines.add(element);
            //               break;
            //             }
            //           }
            //         });
            //       }
            //     });
            //     // setState(() {
            //     //   info.boxs = boxs;
            //     // });
            //     // for (var box in boxs) {
            //     //   _firAuth.addMultiBox(info, uid);
            //     // }
            //     _firAuth.updateBox(info, uid);
            //   }),
            //   child: Icon(Icons.restart_alt_rounded),
            // ),
            // FloatingActionButton(
            //   heroTag: "tag2",
            //   onPressed: () async {
            //     try {
            //       var pickedFile =
            //           await imgpicker.pickImage(source: ImageSource.camera);
            //       if (pickedFile != null) {
            //         setState(() {
            //           _imagepath = pickedFile.path;
            //         });
            //       } else {
            //         print("No image is selected.");
            //       }
            //     } catch (e) {
            //       print("error while picking image.");
            //     }
            //     print("camera");
            //   },
            //   child: Icon(Icons.camera),
            // ),
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
                                    '${box.getMedicine()!.usage.mor.getTime()}'),
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
                                    box.getMedicine()!.usage.mor.time = newtime;
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
                                    '${box.getMedicine()!.usage.noon.getTime()}'),
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
                                    box.getMedicine()!.usage.noon.time =
                                        newtime;
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
                                    '${box.getMedicine()!.usage.even.getTime()}'),
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
                                    box.getMedicine()!.usage.even.time =
                                        newtime;
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

  void instruction(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stepper in Alert Dialog'),
          content: Stepper(
            currentStep: 0,
            onStepTapped: (step) {},
            steps: [
              const Step(
                title: Text('Step 1'),
                content: Text('This is the content of step 1'),
              ),
              Step(
                title: Text('Step 2'),
                content: Text('This is the content of step 2'),
              ),
              Step(
                title: Text('Step 3'),
                content: Text('This is the content of step 3'),
              ),
            ],
          ),
        );
      },
    );
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
                          mor: TimeSlot(quantity: "", time: dateS),
                          noon: TimeSlot(quantity: "", time: dateC),
                          even: TimeSlot(quantity: "", time: dateT)));

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
