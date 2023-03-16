import 'package:app/model/Device.dart';
import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
import 'package:app/view/CreateDevice_Page.dart';
import 'package:app/view/Device_Page.dart';
import 'package:flutter/material.dart';
import '../firebase_store/fire_base_auth.dart';
import '../model/Medicine.dart';
import 'Info_Page.dart';

class DashBoardPage extends StatefulWidget {
  static String routeName = '/DashBoard';
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  var _firAuth = FirAuth();

  TextEditingController nameMedicine = new TextEditingController();
  TextEditingController descripMedicine = new TextEditingController();
  TextEditingController quantityMedicine = new TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as Users;
    Device.ID = info.devices.length;
    return Scaffold(
        appBar: AppBar(title: const Text("Device ")),
        body: Column(
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
                        Icon(Icons.devices),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello :' + info.name,
                                  style: Theme.of(context).textTheme.headline6),
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
                      child: Card(
                        elevation: 4.0, // Add a drop shadow to the card
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
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
                                    Text('Thiet bi so ${item.id}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                    Text('Device Description',
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final rs = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()))
                as Device;
            if (rs != null) {
              print("Receive device : " + rs.Info());
              print(rs.boxs.length);
              setState(() {
                info.devices.add(rs);
                _firAuth.AddMedicine(rs, info.uid);
              });
            }
          },
          child: Icon(Icons.add),
        ));
  }
}
