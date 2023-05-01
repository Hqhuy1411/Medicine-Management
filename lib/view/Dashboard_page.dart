import 'package:app/model/Device.dart';
import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
import 'package:app/view/CreateDevice_Page.dart';
import 'package:app/view/Device_Page.dart';
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:time_picker_widget/main.dart';
import '../firebase_store/fire_base_auth.dart';
import '../model/Medicine.dart';
import 'Bottom_Page.dart';
import 'Info_Page.dart';

class DashBoardPage extends StatefulWidget {
  static String routeName = '/DashBoard';
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var _firAuth = FirAuth();

  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as Users;
    return Scaffold(
        // appBar: AppBar(title: const Text("Device ")),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: 340,
                  height: 50,
                  color: Color(0xff64abbf),
                  margin:
                      EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                  child: Stack(
                    children: [
                      Positioned(
                        top:
                            5, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                        right:
                            5, // set vị trí đứng từ phải qua, dựa vào giá trị x
                        child: IconButton(
                          icon: Icon(
                            Icons.logout_outlined,
                            color: Color(0xFFFFFFFF),
                          ),
                          onPressed: () {
                            // Navigator.popUntil(context, ModalRoute.withName('/'));
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        // top: 30, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                        // left: 0, // set vị trí đứng từ trái qua, dựa vào giá trị x
                        // right: 0,
                        child: Center(
                          child: Text(
                            'SMART MEDICINE BOX',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: 300,
                //   height: 100,

                //   margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
                //   decoration: BoxDecoration(
                //     color: Color(0xff64abbf),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Stack(
                //     children: [
                //       Positioned(
                //         // top: 30, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                //         // left: 0, // set vị trí đứng từ trái qua, dựa vào giá trị x
                //         // right: 0,
                //         child: Center(
                //           child: Text(
                //                     textAlign: TextAlign.center,
                //                     'Hi ' + info.name + '!',
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 20.0,
                //                       ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // GestureDetector(
                //     onTap: () {
                //       // Handle the tap event here
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (context) => const InfoPage()));
                //     },
                //     child: Card(
                //       child: Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: Row(
                //           children: [
                //             Icon(Boxicons.bxs_user_account),
                //             SizedBox(width: 16.0),
                //             Expanded(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text('Hi: ' + info.name,
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .headline6),
                //                   // Text('Device Info',
                //                   //     style: Theme.of(context).textTheme.subtitle1),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )),
                // SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: info.devices.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = info.devices[index];
                      final obSend = {"item": item, "uid": info.uid};
                      return GestureDetector(
                          onTap: () {
                            // Handle the tap event here
                            Navigator.pushNamed(context, DevicePage.routeName,
                                arguments: obSend);
                          },
                          child: Slidable(
                              endActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        print("delete");
                                        showDeleteAlertDialog(item, info);
                                      },
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        _displayEditDialog(item, info);
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
                                    horizontal: 10.0, vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Boxicons.bx_archive,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'DEVICE ${item.id}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            Text(
                                              'Device Description : ${item.description}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              'Name Patient : ${item.patient.fullname}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    },
                  ),
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff64abbf),
          onPressed: () async {
            final rs = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()))
                as Device;
            if (rs != null) {
              print("Receive device : " + rs.Info());
              print(rs.boxs.length);
              setState(() {
                rs.id = info.devices.length + 1;
                info.devices.add(rs);
                _firAuth.AddMedicine(rs, info.uid);
              });
            }
          },
          child: Icon(Icons.add, color: Color(0xFFFFFFFF)),
        ));
  }

  Future<void> _displayEditDialog(Device device, Users user) async {
    TextEditingController nameMedicine =
        TextEditingController(text: device.id.toString());
    TextEditingController descripMedicine =
        TextEditingController(text: device.description);
    TextEditingController quantityMedicine =
        new TextEditingController(text: device.patient.fullname);
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 400,
              color: Colors.white,
              margin: EdgeInsets.only(top: 0, bottom: 10, left: 40, right: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: nameMedicine,
                      decoration: InputDecoration(
                        labelText: "Device's Name",
                        icon: const Icon(Icons.people,
                        color: Color(0xff64abbf),),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: descripMedicine,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        icon: const Icon(Icons.email,
                        color: Color(0xff64abbf),),
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: quantityMedicine,
                      decoration: const InputDecoration(
                        labelText: "Patient's Name",
                        icon: Icon(Icons.message,
                        color: Color(0xff64abbf),),
                      ),
                    ),
                    SizedBox(height: 40,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff64abbf),
                        shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0), // set độ bo góc của nút
                                  ),
                      ),
                      onPressed: () {
                        setState(() {
                          device.description = descripMedicine.text;
                          device.patient.fullname = quantityMedicine.text;
                        });
                        Navigator.pop(context);
                        _firAuth.UpdateDevice(device, user, 0);
                      },
                      child: const Text('Submit',
                        style: TextStyle(
                            color: Colors.white, // set màu sắc của chữ bên trong nút
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),

                      // child: const Text('Close BottomSheet'),
                      
                    ),
                  ],
                ),
              ));
        });
  }

  Future<void> showDeleteAlertDialog(Device device, Users user) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('WARNING!',
            style: TextStyle(
                            color: Color.fromARGB(255, 220, 200, 13), // set màu sắc của chữ bên trong nút
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),),
            content: const Text('Are you sure you want to delete this DEVICE?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff64abbf),
                        shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0), // set độ bo góc của nút
                                  ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('NO',
                        style: TextStyle(
                            color: Colors.white, // set màu sắc của chữ bên trong nút
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                  ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0), // set độ bo góc của nút
                                  ),
                      ),
                      onPressed: () {
                        var _firAuth = FirAuth();
                        _firAuth.UpdateDevice(device, user, 1);

                        // Write code to delete item
                        setState(() {
                          user.devices.remove(device);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('YES',
                        style: TextStyle(
                            color: Colors.white, // set màu sắc của chữ bên trong nút
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),

                  // style: ElevatedButton.styleFrom(primary: Colors.red),
                  // onPressed: () {
                  //   var _firAuth = FirAuth();
                  //   _firAuth.UpdateDevice(device, user, 1);

                  //   // Write code to delete item
                  //   setState(() {
                  //     user.devices.remove(device);
                  //   });
                  //   Navigator.pop(context);
                  // },
                  // child: const Text(
                  //   'Delete',
                  // )
                  ),
            ],
          );
        });
  }
}
