import 'package:app/model/Box.dart';
import 'package:app/model/Usage.dart';
import 'package:app/view/Medicine_Page.dart';
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_widget/time_picker_widget.dart' as tpk;
import '../firebase_store/fire_base_auth.dart';
import '../model/Medicine.dart';
import '../model/TimeSlot.dart';

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
        backgroundColor: Color(0xff64abbf),
        title: const Text(
          'SMART MEDICINE BOX',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Card(
                color: Color(0xff64abbf),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.medical_services_outlined,
                          size: 70, color: Colors.white),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('BOX ' + info.id.toString(),
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white)),
                            // Text(
                            //     'Patient:       ' +
                            //         info.patient.fullname
                            //             .toUpperCase()
                            //             .toString(),
                            //     style: TextStyle(
                            //         fontSize: 20, color: Colors.white)),
                            // Text('Info:       ' + info.description,
                            //     style: TextStyle(
                            //         fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            if (info.medicines.length > 0)
              Column(children: [
                Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          print("edit");
                          // _EditdisplayTextInputDialog(context, item, info, device, uid);
                          showEditTime(info, device, uid, 1);
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(width: 15.0),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Container(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: const Text(
                                        'Morning',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[200],
                                            ),
                                            child: Align(
                                                alignment: Alignment
                                                    .centerRight, // Align the text to the right
                                                child: Text(
                                                    DateFormat.jm()
                                                        .format(info
                                                            .getMedicine()
                                                            .usage
                                                            .mor
                                                            .time)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 30))),
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          print("edit");
                          // _EditdisplayTextInputDialog(context, item, info, device, uid);
                          showEditTime(info, device, uid, 2);
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Container(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: const Text(
                                        'Afternoon',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[200],
                                            ),
                                            child: Align(
                                                alignment: Alignment
                                                    .centerRight, // Align the text to the right
                                                child: Text(
                                                    DateFormat.jm()
                                                        .format(info
                                                            .getMedicine()
                                                            .usage
                                                            .noon
                                                            .time)
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                    ))),
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          print("edit");
                          // _EditdisplayTextInputDialog(context, item, info, device, uid);
                          showEditTime(info, device, uid, 1);
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(width: 15.0),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Container(
                                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: const Text(
                                        'Evening',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: 150,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[200],
                                            ),
                                            child: Align(
                                                alignment: Alignment
                                                    .centerRight, // Align the text to the right
                                                child: Text(
                                                    DateFormat.jm()
                                                        .format(info
                                                            .getMedicine()
                                                            .usage
                                                            .even
                                                            .time)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 30))),
                                          )))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ]),
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
                              Navigator.pushNamed(
                                  context, MedicinePage.routeName,
                                  arguments: item);
                            },
                            child: Slidable(
                                endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
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
                                  color: Color(0xff64abbf),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation:
                                      4.0, // Add a drop shadow to the card
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Icon(Boxicons.bxs_capsule,
                                            size: 70, color: Colors.white),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // ignore: prefer_interpolation_to_compose_strings
                                              Text('' + item.name,
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // set màu sắc của chữ bên trong nút
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'Description ' +
                                                      item.description,
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // set màu sắc của chữ bên trong nút
                                                    fontSize: 20,
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  'M : ${item.usage.mor.quantity} A : ${item.usage.noon.quantity} E :${item.usage.even.quantity}',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // set màu sắc của chữ bên trong nút
                                                    fontSize: 20,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )));
                      })
                  : Center(
                      child: Text(
                        'Empty Box',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              // Text("Empty Box"),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff64abbf),
        child: Icon(Icons.add, color: Color(0xFFFFFFFF)),
        onPressed: () {
          if (info.medicines.length > 0) {
            _displayTextInputDialog(context, info, device, uid);
          } else {
            _displayTextInputDialog2(context, info, device, uid);
          }
        },
      ),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, Box box, int device, String uid) async {
    var morMedicine = TextEditingController(text: '0');
    var noonMedicine = TextEditingController(text: '0');
    var eveMedicine = TextEditingController(text: '0');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Medicine'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: nameMedicine,
                    decoration: InputDecoration(
                      labelText: "Medicine's Name",
                      icon: const Icon(
                        Icons.medication_rounded,
                        color: Color(0xff64abbf),
                      ),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: descripMedicine,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      labelText: 'Description',
                      icon: const Icon(
                        Icons.description,
                        color: Color(0xff64abbf),
                      ),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: quantityMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      icon: Icon(
                        Icons.numbers,
                        color: Color(0xff64abbf),
                      ),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: morMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Morning Quantity',
                      icon: Icon(
                        Icons.numbers,
                        color: Color(0xff64abbf),
                      ),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: noonMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Noon Quantity',
                      icon: Icon(
                        Icons.numbers,
                        color: Color(0xff64abbf),
                      ),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: eveMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Evening Quantity',
                      icon: Icon(
                        Icons.numbers,
                        color: Color(0xff64abbf),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // set độ bo góc của nút
                  ),
                ),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color:
                        Color(0xff64abbf), // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff64abbf),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // set độ bo góc của nút
                  ),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white, // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  var _firAuth = FirAuth();
                  Usage usage = box.getMedicine()!.usage;
                  Usage usage2 = Usage(
                      mor: TimeSlot(
                          quantity: (morMedicine.text), time: usage.mor.time),
                      noon: TimeSlot(
                          quantity: (noonMedicine.text), time: usage.noon.time),
                      even: TimeSlot(
                          quantity: (eveMedicine.text), time: usage.even.time));

                  var medicine = Medicine(
                      name: nameMedicine.text,
                      quantity: int.parse(quantityMedicine.text),
                      description: descripMedicine.text,
                      usage: usage2);
                  setState(() {
                    box.medicines.add(medicine);
                  });
                  _firAuth.AddMedicine2(medicine, device, box.id!, uid);

                  Navigator.pop(context);
                  nameMedicine.text = '';
                  quantityMedicine.text = '';
                },
              ),
            ],
          );
        });
  }

  Future<void> _EditdisplayTextInputDialog(BuildContext context,
      Medicine medicine, Box box, int device, String uid) async {
    nameMedicine = TextEditingController(text: medicine.name);
    descripMedicine = TextEditingController(text: medicine.description);
    quantityMedicine =
        TextEditingController(text: medicine.quantity.toString());
    var morMedicine =
        TextEditingController(text: medicine.usage.mor.quantity.toString());
    var noonMedicine =
        TextEditingController(text: medicine.usage.noon.quantity.toString());
    var eveMedicine =
        TextEditingController(text: medicine.usage.even.quantity.toString());

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
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: morMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Sang',
                      icon: Icon(Icons.message),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: noonMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Chieu',
                      icon: Icon(Icons.message),
                    ),
                  ),
                  TextFormField(
                    // ignore: prefer_const_constructors
                    controller: eveMedicine,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Toi',
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
                    medicine.name = nameMedicine.text;
                    medicine.description = descripMedicine.text;
                    medicine.quantity = int.parse(quantityMedicine.text);

                    medicine.usage.mor.quantity = (morMedicine.text);
                    medicine.usage.noon.quantity = (noonMedicine.text);
                    medicine.usage.even.quantity = (eveMedicine.text);
                  });

                  Navigator.pop(context);
                  _firAuth.UpdateMedicine(box, device, uid);
                  print(box.id);
                  print(device);
                  print(uid);
                },
              ),
            ],
          );
        });
  }

  Future<void> showDeleteAlertDialog(
      Box box, Medicine medicine, int device, String uid) async {
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

  Future<void> _displayTextInputDialog2(
      BuildContext context, Box box, int device, String uid) async {
    DateTime dateS = DateTime(2023, 1, 1);
    DateTime dateC = DateTime(2023, 1, 1);
    DateTime dateT = DateTime(2023, 1, 1);
    var morMedicine = TextEditingController(text: '0');
    var noonMedicine = TextEditingController(text: '0');
    var eveMedicine = TextEditingController(text: '0');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Medicine'),
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
                          labelText: "Medicine's Name",
                          icon: const Icon(
                            Icons.medication_rounded,
                            color: Color(0xff64abbf),
                          ),
                        ),
                      ),
                      TextFormField(
                        // ignore: prefer_const_constructors
                        controller: descripMedicine,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Description',
                          icon: const Icon(
                            Icons.description,
                            color: Color(0xff64abbf),
                          ),
                        ),
                      ),
                      TextFormField(
                        // ignore: prefer_const_constructors
                        controller: quantityMedicine,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          icon: Icon(
                            Icons.numbers,
                            color: Color(0xff64abbf),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: morMedicine,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Morning Qty',
                                icon: Icon(
                                  Icons.numbers,
                                  color: Color(0xff64abbf),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff64abbf),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // set độ bo góc của nút
                                  ),
                                ),
                                child: dateS.hour == 0
                                    ? Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: Colors
                                              .white, // set màu sắc của chữ bên trong nút
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Text('${dateS.hour}' ': ${dateS.minute}'),
                                onPressed: () async {
                                  final time = await pickTime(0);
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
                              controller: noonMedicine,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Noon Qty',
                                icon: Icon(
                                  Icons.numbers,
                                  color: Color(0xff64abbf),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff64abbf),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // set độ bo góc của nút
                                  ),
                                ),
                                child: dateC.hour == 0
                                    ? Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: Colors
                                              .white, // set màu sắc của chữ bên trong nút
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Text('${dateC.hour}' ': ${dateC.minute}'),
                                onPressed: () async {
                                  final time = await pickTime(1);
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
                              controller: eveMedicine,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Evening Qty',
                                icon: Icon(
                                  Icons.numbers,
                                  color: Color(0xff64abbf),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff64abbf),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // set độ bo góc của nút
                                  ),
                                ),
                                child: dateT.hour == 0
                                    ? Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: Colors
                                              .white, // set màu sắc của chữ bên trong nút
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Text('${dateT.hour}' ': ${dateT.minute}'),
                                onPressed: () async {
                                  final time = await pickTime(2);
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
                // child: Text('CANCEL'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // set độ bo góc của nút
                  ),
                ),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color:
                        Color(0xff64abbf), // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff64abbf),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // set độ bo góc của nút
                  ),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white, // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  var _firAuth = FirAuth();
                  Medicine medicine = Medicine(
                      name: nameMedicine.text,
                      description: descripMedicine.text,
                      quantity: int.parse(quantityMedicine.text),
                      usage: Usage(
                          mor: TimeSlot(
                              quantity: (morMedicine.text), time: dateS),
                          noon: TimeSlot(
                              quantity: (noonMedicine.text), time: dateC),
                          even: TimeSlot(
                              quantity: (eveMedicine.text), time: dateT)));

                  setState(() {
                    box.medicines.add(medicine);
                    // Box box = Box(medicines: [medicine]);
                    // box.id = device.boxs.length + 1;
                    // device.boxs.add(box);
                    // _firAuth.addBox(box, device.id!, uid);
                  });
                  _firAuth.AddMedicine2(medicine, device, box.id!, uid);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<TimeOfDay?> pickTime(int buoi) {
    int min = 0;
    int max = 0;
    if (buoi == 0) {
      min = 5;
      max = 9;
    } else if (buoi == 1) {
      min = 10;
      max = 15;
    } else {
      min = 16;
      max = 21;
    }
    return tpk.showCustomTimePicker(
        context: context,
        onFailValidation: (context) => print('Unavailable selection'),
        initialTime: buoi == 0
            ? TimeOfDay(hour: 7, minute: 0)
            : buoi == 1
                ? TimeOfDay(hour: 11, minute: 30)
                : TimeOfDay(hour: 18, minute: 30),
        selectableTimePredicate: (time) =>
            time!.minute % 15 == 0 && time.hour >= min && time.hour <= max);
  }

  Future<void> showEditTime(Box box, int device, String uid, int buoi) async {
    DateTime dateS = DateTime(2023, 1, 1);
    DateTime dateC = DateTime(2023, 1, 1);
    DateTime dateT = DateTime(2023, 1, 1);
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
                          if (buoi == 1)
                            Expanded(
                              child: ElevatedButton(
                                  child: Text(
                                      '${box.getMedicine()!.usage.mor.getTime()}'),
                                  onPressed: () async {
                                    dateS = box.getMedicine()!.usage.mor.time;
                                    final time = await pickTime(0);
                                    if (time == null) return;
                                    final newtime = DateTime(
                                        dateS.year,
                                        dateS.month,
                                        dateS.day,
                                        time.hour,
                                        time.minute);
                                    setState(() {
                                      box.getMedicine()!.usage.mor.time =
                                          newtime;
                                    });
                                  }),
                            ),
                          if (buoi == 2)
                            Expanded(
                              child: ElevatedButton(
                                  child: Text(
                                      '${box.getMedicine()!.usage.noon.getTime()}'),
                                  onPressed: () async {
                                    dateC = box.getMedicine()!.usage.noon.time;
                                    final time = await pickTime(1);
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
                            ),
                          if (buoi == 3)
                            Expanded(
                              child: ElevatedButton(
                                  child: Text(
                                      '${box.getMedicine()!.usage.even.getTime()}'),
                                  onPressed: () async {
                                    dateT = box.getMedicine()!.usage.even.time;
                                    final time = await pickTime(2);
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // set độ bo góc của nút
                  ),
                ),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color:
                        Color(0xff64abbf), // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff64abbf),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // set độ bo góc của nút
                  ),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white, // set màu sắc của chữ bên trong nút
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
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
}
