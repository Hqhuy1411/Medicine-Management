import 'package:app/model/Device.dart';
import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
import 'package:app/view/CreateDevice_Page.dart';
import 'package:app/view/Device_Page.dart';
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        appBar: AppBar(title: const Text("Device ")),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const InfoPage()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Boxicons.bxs_user_account),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hello :' + info.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  // Text('Device Info',
                                  //     style: Theme.of(context).textTheme.subtitle1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(height: 16.0),
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
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 4.0, // Add a drop shadow to the card
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Boxicons.bx_package,
                                        size: 50,
                                      ),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Thiet bi so ${item.id}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            Text(
                                                'Device Description : ${item.description}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                            Text(
                                                'Name Patient : ${item.patient.fullname}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
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
          child: Icon(Icons.add),
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
              color: Colors.amberAccent,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: nameMedicine,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextFormField(
                      controller: descripMedicine,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        icon: const Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      controller: quantityMedicine,
                      decoration: const InputDecoration(
                        labelText: 'Name Patient',
                        icon: Icon(Icons.message),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () {
                        setState(() {
                          device.description = descripMedicine.text;
                          device.patient.fullname = quantityMedicine.text;
                        });
                        Navigator.pop(context);
                        _firAuth.UpdateDevice(device, user, 0);
                      },
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
            title: const Text('Delete?'),
            content: const Text('Are you sure you want to delete this item?'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    var _firAuth = FirAuth();
                    _firAuth.UpdateDevice(device, user, 1);

                    // Write code to delete item
                    setState(() {
                      user.devices.remove(device);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                  )),
            ],
          );
        });
  }
}
