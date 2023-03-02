import 'package:app/model/Device.dart';
import 'package:app/model/Usage.dart';
import 'package:app/model/Users.dart';
import 'package:app/view/text_dialog_widget.dart';
import 'package:flutter/material.dart';
import '../firebase_store/fire_base_auth.dart';
import '../model/Medicine.dart';
import '../utils/Row.dart';
import 'Scrollable_widget.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/Home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _firAuth = FirAuth();

  TextEditingController nameMedicine = new TextEditingController();
  TextEditingController descripMedicine = new TextEditingController();
  TextEditingController quantityMedicine = new TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments as Users;
    return Scaffold(
      appBar: AppBar(title: const Text("ListView.builder")),
      body: ListView.builder(
          itemCount: info.devices.length,
          itemBuilder: (BuildContext context, int index) {
            final item = info.devices[index];
            return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, BoxPage.routeName,
                      arguments: item);
                },
                leading: const Icon(Icons.list),
                trailing: const Text(
                  "GFG",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("Ten Thiet bi :" + item.name));
          }),
    );
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: (() {
    //         _displayTextInputDialog(context, info);
    //       }),
    //       child: const Icon(Icons.add)),
    // );
  }

  Widget buildDataTable(Users users) {
    final columns = ['Ten Thuoc', 'Mo Ta', 'So Luong', 'Sang', 'Chieu', 'Toi'];

    return DataTable(
      columns: getColumns(columns),
      rows: getRows(users.devices, users.uid),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  late Medicine medicine;

  List<DataRow> getRows(List<Medicine> medicines, String uid) =>
      medicines.map((Medicine medicine) {
        final cells = [
          medicine.name,
          medicine.description,
          medicine.quantity,
          medicine.usage.mor.quantity,
          medicine.usage.noon.quantity,
          medicine.usage.even.quantity
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(Text('$cell'), showEditIcon: true, onTap: () async {
              final nameEdit = await openDialog(medicine, index);
              print(index);
              // List<Medicine> list = medicines
              //     .map((e) => e == medicine
              //         ? e.copy(usage: e.usage.copy(mor: int.parse(nameEdit)))
              //         : e)
              //     .toList();
              List<Medicine> list =
                  checkEdit(medicines, index, nameEdit, medicine);
              setState(() {
                medicines.clear();
                for (var element in list) {
                  medicines.add(element);
                }
                // _firAuth.UpdateMedicine(medicines, uid);
              });
            });
          }),
        );
      }).toList();
  List<Medicine> checkEdit(
      List<Medicine> list, int index, String nameEdit, Medicine medicine) {
    switch (index) {
      case 0:
        list = list
            .map((e) => e == medicine ? e.copy(name: nameEdit) : e)
            .toList();
        break;
      case 1:
        list = list
            .map((e) => e == medicine ? e.copy(description: nameEdit) : e)
            .toList();
        break;
      case 2:
        list = list
            .map((e) =>
                e == medicine ? e.copy(quantity: int.parse(nameEdit)) : e)
            .toList();
        break;
      // case 3:
      //   list = list
      //       .map((e) => e == medicine
      //           ? e.copy(usage: e.usage.copy(mor: int.parse(nameEdit)))
      //           : e)
      //       .toList();
      //   break;
      // case 4:
      //   list = list
      //       .map((e) => e == medicine
      //           ? e.copy(usage: e.usage.copy(noon: int.parse(nameEdit)))
      //           : e)
      //       .toList();
      //   break;
      // case 5:
      //   list = list
      //       .map((e) => e == medicine
      //           ? e.copy(usage: e.usage.copy(even: int.parse(nameEdit)))
      //           : e)
      //       .toList();
      //   break;
      default:
    }
    return list;
  }

  Future openDialog(Medicine medicine, int index) {
    var controller2;
    switch (index) {
      case 0:
        controller2 = TextEditingController(text: medicine.name);
        break;
      case 1:
        controller2 = TextEditingController(text: medicine.description);
        break;
      case 2:
        controller2 = TextEditingController(text: medicine.quantity.toString());
        break;
      case 3:
        controller2 =
            TextEditingController(text: medicine.usage.mor.toString());
        break;
      case 4:
        controller2 =
            TextEditingController(text: medicine.usage.noon.toString());
        break;
      case 5:
        controller2 =
            TextEditingController(text: medicine.usage.even.toString());
        break;
      default:
    }
    return showDialog(
        context: context,
        // ignore: prefer_const_constructors
        builder: (context) => AlertDialog(
              title: const Text('Edit'),
              content: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    hintText: 'You Edit', border: OutlineInputBorder()),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Done'),
                  onPressed: () => Navigator.of(context).pop(controller2.text),
                )
              ],
            ));
  }

  Future<void> _displayTextInputDialog(BuildContext context, Users info) async {
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
                  // setState(() {
                  //   medicine = Medicine(
                  //       name: nameMedicine.text,
                  //       quantity: int.parse(quantityMedicine.text),
                  //       description: descripMedicine.text,
                  //       usage: Usage());
                  //   _firAuth.AddMedicine(medicine, info.uid);
                  //   info.medicines.add(medicine);
                  //   Navigator.pop(context);
                  // });
                  // nameMedicine.text = '';
                  // quantityMedicine.text = '';
                },
              ),
            ],
          );
        });
  }
}

class BoxPage extends StatelessWidget {
  static String routeName = '/Box';
  const BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final info = ModalRoute.of(context)!.settings.arguments as Device;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(info.name), Text(info.patient.fullname)],
      )),
    );
  }
}
