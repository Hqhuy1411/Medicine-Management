import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MyListPage extends StatefulWidget {
  var boxs;

  MyListPage({Key? key, required this.boxs}) : super(key: key);

  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  int _currentIndex = 0;
  FlutterTts flutterTts = FlutterTts();

  void textToSpeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff64abbf),
        title: Center(
          child: Text(
            'SMART MEDICINE BOX',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: Color(0xff64abbf),
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'images/device.png', // Replace with the actual image path
                            width: 180,
                            height: 130,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "HOW TO SET UP",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "MEDICNES",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )
                            ],
                          ))
                        ],
                      ),
                      Text(
                        "Instruction to put  medicine right in box",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Color(0xff64abbf),
                elevation: 4.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Boxicons.bx_box, size: 70, color: Colors.white),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "BOX" +
                                    widget.boxs[_currentIndex].id.toString(),
                                style: TextStyle(
                                  color: Colors
                                      .white, // set màu sắc của chữ bên trong nút
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            for (var medicine
                                in widget.boxs[_currentIndex].medicines)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 7.0),
                                child: Text(
                                  "Medince :" + medicine.name,
                                  style: TextStyle(
                                    color: Colors
                                        .white, // set màu sắc của chữ bên trong nút
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _currentIndex > 0 ? _handlePrev : null,
                    child: Text('PREV'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff64abbf)),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _currentIndex < widget.boxs.length - 1
                        ? _handleNext
                        : _handleOk,
                    child: Text(
                        _currentIndex < widget.boxs.length - 1 ? 'NEXT' : 'OK'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff64abbf)),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _handlePrev() {
    setState(() {
      _currentIndex--;
    });
    textToSpeech(
        "Box ${_currentIndex} has ${widget.boxs[_currentIndex].listNameMedicines()}");
  }

  void _handleNext() {
    setState(() {
      _currentIndex++;
    });
    textToSpeech(
        "Box ${_currentIndex} has ${widget.boxs[_currentIndex].listNameMedicines()}");
  }

  void _handleOk() {
    Navigator.of(context).pop();
  }
}
