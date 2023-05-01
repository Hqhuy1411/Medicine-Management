import 'package:app/model/Box.dart';
import 'package:app/model/Device.dart';
import 'package:app/model/Patient.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _activeStepIndex = 0;
  var device;
  TextEditingController nameDevice = TextEditingController();
  TextEditingController descriptionDevice = TextEditingController();
  TextEditingController namePatient = TextEditingController();
  //TextEditingController pincode = TextEditingController();

  

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Device',
            style: TextStyle(
              fontSize: 20, // Thiết lập cỡ chữ là 20
              color: Color(0xff64abbf), // Thiết lập màu chữ là đen
              fontWeight: FontWeight.bold,
            ),),
          content: Container(
            child: Column(children: [
              TextField(
                controller: nameDevice,
                style: TextStyle(
                  color: Colors.black, // màu chữ
                  fontSize: 15, // kích thước chữ
                ),
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  // labelText: 'Name of Device',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // bo góc
                    // borderSide: BorderSide.none,
                  ),
                  // border: InputBorder.none, // loại bỏ đường viền
                  // contentPadding: EdgeInsets.symmetric(vertical: 10), // khoảng cách giữa đường viền và văn bản
                  hintText: "Device's Name", // placeholder
                  hintStyle: TextStyle(
                    color: Colors.grey, // màu placeholder
                    fontSize: 15, // kích thước placeholder
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: descriptionDevice,
                style: TextStyle(
                  color: Colors.black, // màu chữ
                  fontSize: 15, // kích thước chữ
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // bo góc
                    // borderSide: BorderSide.none,
                  ),
                  hintText: "Description", // placeholder
                  hintStyle: TextStyle(
                    color: Colors.grey, // màu placeholder
                    fontSize: 15, // kích thước placeholder
                  ),
                ),
              ),
              // TextField(
              //   controller: descriptionDevice,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Description',
              //   ),
              // ),
              const SizedBox(
                height: 8,
              ),
            ]),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Patient',
              style: TextStyle(
                fontSize: 20, // Thiết lập cỡ chữ là 20
                color: Color(0xff64abbf), // Thiết lập màu chữ là đen
                fontWeight: FontWeight.bold,
              ),),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: namePatient,
                    style: TextStyle(
                      color: Colors.black, // màu chữ
                      fontSize: 15, // kích thước chữ
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // bo góc
                        // borderSide: BorderSide.none,
                      ),
                      hintText: "Patient's Name", // placeholder
                      hintStyle: TextStyle(
                        color: Colors.grey, // màu placeholder
                        fontSize: 15, // kích thước placeholder
                      ),
                    ),
                  ),
                  // TextField(
                  //   controller: namePatient,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Full name of Patient',
                  //   ),
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm',
              style: TextStyle(
                fontSize: 20, // Thiết lập cỡ chữ là 20
                color: Color(0xff64abbf), // Thiết lập màu chữ là đen
                fontWeight: FontWeight.bold,
              ),),
            content: Container(
              height: 100, // đặt chiều cao là 200
              width: 250, // đặt chiều rộng là 300
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xff64abbf),
                      ),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${nameDevice.text}',
                  style: TextStyle(
                    fontSize: 15, // Thiết lập cỡ chữ là 20
                    color: Colors.white, // Thiết lập màu chữ là đen
                  ),),
                Text('Email: ${descriptionDevice.text}',
                  style: TextStyle(
                    fontSize: 15, // Thiết lập cỡ chữ là 20
                    color: Colors.white, // Thiết lập màu chữ là đen
                  ),),
                Text('Address : ${namePatient.text}',
                  style: TextStyle(
                    fontSize: 15, // Thiết lập cỡ chữ là 20
                    color: Colors.white, // Thiết lập màu chữ là đen
                  ),),
              ],
            )
            ))
      ];

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff64abbf),
              shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // set độ bo góc của nút
                        ),
            ),
            onPressed: details.onStepContinue,
            child: const Text('Next',
              style: TextStyle(
                  color: Colors.white, // set màu sắc của chữ bên trong nút
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
          ),
          const SizedBox(width: 10),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // set độ bo góc của nút
                        ),
            ),
            onPressed: details.onStepCancel,
            child: const Text('Back',
              style: TextStyle(
                  color: Color(0xff64abbf), // set màu sắc của chữ bên trong nút
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
          ),
          // OutlinedButton(
          //   onPressed: details.onStepCancel,
          //   child: const Text('Back'),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Stepper'),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                  width: 340,
                  height: 50,
                  color: Color(0xff64abbf),
                  margin: EdgeInsets.only(top: 30, bottom: 40, left: 10, right: 10),
                  child: Stack(
                    children: [
                      Positioned(
                        top:
                            5, // set vị trí đứng từ trên xuống, dựa vào giá trị y
                        left:
                            5, // set vị trí đứng từ phải qua, dựa vào giá trị x
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: Color(0xFFFFFFFF),
                          ),
                          onPressed: () {
                            // Navigator.popUntil(context, ModalRoute.withName('/'));
                            Navigator.pop(context);
                          },
                        ),
                      ),

                      Positioned(
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
        Stepper(
          type: StepperType.vertical,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex < (stepList().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              print('Submited');
              List<Box> list = [];
              device = Device(
                  description: descriptionDevice.text,
                  patient: Patient(fullname: namePatient.text, id: ""),
                  boxs: list);
              Navigator.pop(context, device);
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
          controlsBuilder: controlBuilders,
        ),
          ],
      ),
      ),
      // body: Stepper(
      //   type: StepperType.vertical,
      //   currentStep: _activeStepIndex,
      //   steps: stepList(),
      //   onStepContinue: () {
      //     if (_activeStepIndex < (stepList().length - 1)) {
      //       setState(() {
      //         _activeStepIndex += 1;
      //       });
      //     } else {
      //       print('Submited');
      //       List<Box> list = [];
      //       device = Device(
      //           description: descriptionDevice.text,
      //           patient: Patient(fullname: namePatient.text, id: ""),
      //           boxs: list);
      //       Navigator.pop(context, device);
      //     }
      //   },
      //   onStepCancel: () {
      //     if (_activeStepIndex == 0) {
      //       return;
      //     }

      //     setState(() {
      //       _activeStepIndex -= 1;
      //     });
      //   },
      //   onStepTapped: (int index) {
      //     setState(() {
      //       _activeStepIndex = index;
      //     });
      //   },
      //   controlsBuilder: controlBuilders,
      // ),
    );
  }
}
