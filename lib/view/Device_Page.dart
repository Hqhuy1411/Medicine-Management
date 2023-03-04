import 'package:app/model/Device.dart';
import 'package:app/view/Box_Page.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
