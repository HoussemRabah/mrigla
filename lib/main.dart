import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Controls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter UI Controls Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? _dropdownButtonValue = 'One';
  String? _popupMenuButtonValue = 'One';
  bool? _checkboxValue = true;
  String? _radioBoxValue = 'One';
  double _sliderValue = 10;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('Buttons'),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    buttonMinWidth: 200,
                    buttonHeight: 30,
                    buttonAlignedDropdown: true,
                    layoutBehavior: ButtonBarLayoutBehavior.padded,
                    buttonPadding: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _showToast('Clicked on RaisedButton'),
                        child: Text('Raised Button'),
                      ),
                      FlatButton(
                        onPressed: () => _showToast('Clicked on FlatButton'),
                        child: Text('Flat Button'),
                      ),
                      OutlineButton(
                        onPressed: () => _showToast('Clicked on OutlineButton'),
                        child: Text('OutlineButton'),
                      ),
                      Row(
                        children: <Widget>[
                          Text('IconButton: '),
                          IconButton(
                            onPressed: () =>
                                _showToast('Clicked on IconButton'),
                            icon: Icon(Icons.build),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('DropdownButton: '),
                          DropdownButton(
                              value: _dropdownButtonValue,
                              onChanged: (String? value) {
                                setState(() {
                                  _dropdownButtonValue = value;
                                });
                                _showToast(
                                    'Changed value of dropdown button to $value'
                                );
                              },
                              items: ['One', 'Two', 'Three', 'Four'].map<
                                  DropdownMenuItem<String>>((String value) =>
                                  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  )
                              ).toList()
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('PopupMenuButton: '),
                          Text(_popupMenuButtonValue!),
                          PopupMenuButton<String>(
                              onSelected: (String result) {
                                setState(() {
                                  _popupMenuButtonValue = result;
                                });
                                _showToast(
                                    'Selected \'$result\' item on PopupMenuButton');
                              },
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'One',
                                  child: Text('One'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Two',
                                  child: Text('Two'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Three',
                                  child: Text('Three'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Four',
                                  child: Text('Four'),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              _SpaceLine(),
              // Checkbox
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _GroupText('Checkbox'),
                    Row(
                      children: <Widget>[
                        Text('Simple checkbox'),
                        Checkbox(value: _checkboxValue,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _checkboxValue = newValue;
                              });
                              _showToast(
                                  'Changed value of checkbox to $_checkboxValue');
                            }),
                      ],
                    )
                  ]
              ),
              _SpaceLine(),
              // Radio[Box]
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('Radio[Box]'),
                  RadioListTile(
                      title: const Text('One'),
                      value: 'One',
                      groupValue: _radioBoxValue,
                      onChanged: (String? value) {
                        setState(() {
                          _radioBoxValue = value;
                        });
                        _showToast('Changed value of Radio[Box] to $value');
                      }),
                  RadioListTile(
                      title: const Text('Two'),
                      value: 'Two',
                      groupValue: _radioBoxValue,
                      onChanged: (String? value) {
                        setState(() {
                          _radioBoxValue = value;
                        });
                        _showToast('Changed value of Radio[Box] to $value');
                      }),
                  RadioListTile(
                      title: const Text('Three'),
                      value: 'Three',
                      groupValue: _radioBoxValue,
                      onChanged: (String? value) {
                        setState(() {
                          _radioBoxValue = value;
                        });
                        _showToast('Changed value of Radio[Box] to $value');
                      }),
                  RadioListTile(
                      title: const Text('Four'),
                      value: 'Four',
                      groupValue: _radioBoxValue,
                      onChanged: (String? value) {
                        setState(() {
                          _radioBoxValue = value;
                        });
                        _showToast('Changed value of Radio[Box] to $value');
                      }),
                ],
              ),
              _SpaceLine(),
              // Slider
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('Slider'),
                  Slider(
                    value: _sliderValue,
                    onChanged: (newValue) {
                      setState(() {
                        _sliderValue = newValue;
                      });
                    },
                    min: 0,
                    max: 100,
                    divisions: 50,
                    label: _sliderValue.toInt().toString(),
                  ),
                ],
              ),
              _SpaceLine(),
              // Switch
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('Switch'),
                  Row(
                    children: <Widget>[
                      Text('Simple switch'),
                      Switch(
                        value: _switchValue,
                        onChanged: (newValue) {
                          setState(() {
                            _switchValue = newValue;
                          });
                          _showToast('Changed value of Switch to $newValue');
                        },
                      )
                    ],
                  ),
                ],
              ),
              _SpaceLine(),
              // TextField
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('TextField'),
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'TextField',
                    ),
                  ),
                ],
              ),
              _SpaceLine(),
              // DateTimePicker
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('DateTimePicker'),
                  OutlinedButton(
                    onPressed: () {
                      showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now(),
                      )
                      .then((value) {
                        _showToast('Selected date $value');
                      });
                    },
                    child: Text('Open DatePicker'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        _showToast('Selected time $value');
                      });
                    },
                    child: Text('Open TimePicker'),
                  ),
                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showToast('Clicked on float action button'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showToast(String text) {
    _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(text),
          duration: Duration(seconds: 1),
        )
    );
  }
}

class _GroupText extends StatelessWidget {
  final String text;

  const _GroupText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(text,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}

class _SpaceLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 5,
      child: Container(color: Colors.grey,),
    );
  }
}
