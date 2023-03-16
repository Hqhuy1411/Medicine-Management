import 'package:app/model/Box.dart';
import 'package:app/model/Usage.dart';
import 'package:app/view/Medicine_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../firebase_store/fire_base_auth.dart';
import '../model/Medicine.dart';

class BoxPage extends StatefulWidget {
  const BoxPage({super.key});
  static String routeName = '/Box';

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  TextEditingController nameMedicine = new TextEditingController();
  TextEditingController descripMedicine = new TextEditingController();
  TextEditingController quantityMedicine = new TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    var obRecei = ModalRoute.of(context)!.settings.arguments;
    obRecei = Map<String, dynamic>.from(obRecei as Map);
    final info = obRecei['item'];
    final uid = obRecei['uid'];
    final device = obRecei['device'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
      ),
      body: Column(children: [
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
          child: info.medicines.length != 0
              ? ListView.builder(
                  itemCount: info.medicines.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = info.medicines[index];
                    return GestureDetector(
                        onTap: () {
                          // Handle the tap event here
                          Navigator.pushNamed(context, MedicinePage.routeName,
                              arguments: item);
                        },
                        child: Slidable(
                            endActionPane:
                                ActionPane(motion: StretchMotion(), children: [
                              SlidableAction(
                                onPressed: (context) {
                                  print("delete" + item.Info());
                                  showDeleteAlertDialog(
                                      info, item, device, uid);
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  print("edit");
                                  _EditdisplayTextInputDialog(
                                      context, item, info, device, uid);
                                },
                                icon: Icons.edit,
                                backgroundColor: Colors.blue,
                              ),
                            ]),
                            child: Card(
                              elevation: 4.0, // Add a drop shadow to the card
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.medical_information),
                                    SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ignore: prefer_interpolation_to_compose_strings
                                          Text('Medicine Name:' + item.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                          Text(
                                              'Medicine Description ' +
                                                  item.description,
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
                  })
              : Text("Chua co thong tin ve hop"),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context, info, device, uid);
        },
      ),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Box box, String device, String uid) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: nameMedicine,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      icon: const Icon(Icons.account_box),
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
                ],
              )),
            ),
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
                    Usage usage = box.getMedicine().usage;
                    var medicine = Medicine(
                        name: nameMedicine.text,
                        quantity: int.parse(quantityMedicine.text),
                        description: descripMedicine.text,
                        usage: usage);
                    _firAuth.AddMedicine2(medicine, device, box.name, uid);
                    box.medicines.add(medicine);
                    Navigator.pop(context);
                  });
                  nameMedicine.text = '';
                  quantityMedicine.text = '';
                },
              ),
            ],
          );
        });
  }

  Future<void> _EditdisplayTextInputDialog(BuildContext context,
      Medicine medicine, Box box, String device, String uid) async {
    nameMedicine = TextEditingController(text: medicine.name);
    descripMedicine = TextEditingController(text: medicine.description);
    quantityMedicine =
        TextEditingController(text: medicine.quantity.toString());
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: nameMedicine,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      icon: const Icon(Icons.account_box),
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
                ],
              )),
            ),
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
                    //box.medicines.remove(medicine);
                    box.medicines = box.medicines
                        .map((e) =>
                            e == medicine ? e.copy(name: nameMedicine.text) : e)
                        .toList();
                    Navigator.pop(context);
                  });
                  _firAuth.UpdateMedicine(box, device, uid);
                  nameMedicine.text = '';
                },
              ),
            ],
          );
        });
  }

  Future<void> showDeleteAlertDialog(
      Box box, Medicine medicine, String device, String uid) async {
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

                    // Write code to delete item
                    setState(() {
                      box.medicines.remove(medicine);
                    });
                    _firAuth.UpdateMedicine(box, device, uid);
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
