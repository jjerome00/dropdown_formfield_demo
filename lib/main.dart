import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validating DropDown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Validating DropDown'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, MaterialColor> _dropdownValues = {'': null, 'red': Colors.red, 'green': Colors.green, 'blue': Colors.blue, 'orange': Colors.orange};

  String _name;
  String _chosenValue = '';

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    print('========================================');

    if (!form.validate()) {
      print('Form NOT VALID');
    } else {
      form.save();
      String message = 'Form Valid: Name: $_name; Color: $_chosenValue';
      print(message);
      showMessage(message, _dropdownValues[_chosenValue]);
    }

    print('========================================');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
              key: _formKey,
              autovalidate: false,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'A name is required' : null,
                    onSaved: (val) => _name = val,
                  ),
                  FormField<String>(
                    initialValue: _chosenValue,
                    onSaved: (val) => _chosenValue = val,
                    validator: (val) => (val == null || val.isEmpty) ? 'Please choose a color' : null,
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: Icon(Icons.color_lens),
                          labelText: 'Favorite Color',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: state.value == '' || state.value == null,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.value,
                            isDense: true,
                            onChanged: (String newValue) {
                              if (newValue == '') {
                                newValue = null;
                              }
                              state.didChange(newValue);
                            },
                            items: _dropdownValues.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                      padding: EdgeInsets.all(40.0),
                      child: RaisedButton(
                        child: Text('Submit'),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }
}
