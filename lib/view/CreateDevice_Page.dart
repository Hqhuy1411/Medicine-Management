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
          title: const Text('Device'),
          content: Container(
            child: Column(children: [
              TextField(
                controller: nameDevice,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name of Device',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: descriptionDevice,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
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
            title: const Text('Patient'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: namePatient,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full name of Patient',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${nameDevice.text}'),
                Text('Email: ${descriptionDevice.text}'),
                Text('Address : ${namePatient.text}'),
              ],
            )))
      ];

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: const Text('Next'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stepper'),
      ),
      body: Stepper(
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
                name: nameDevice.text,
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
    );
  }
}
