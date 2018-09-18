import 'package:dropdown_formfield_demo/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyFormFieldApp());


class MyFormFieldApp extends StatelessWidget {
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

  List<String> _dropdownValues = <String>['', 'red', 'green', 'blue', 'orange'];
  String _name;
  String _chosenValue = '';

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate() ) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();

      print('========================================');
      print('Form Saved:');
      print('Email: $_name');
      print('Favorite Color: $_chosenValue');
      print('========================================');
      print('');
    }
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
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'A name is required' : null,
                    onSaved: (val) => _name = val,
                  ),
                  DropdownFormField<String>(
                    hint: 'Color',
                    value: _chosenValue,
                    items: _dropdownValues.toList(),
                    onChanged: (val) => setState(() { _chosenValue = val; }),
                    validator: (val) => (val == null || val.isEmpty) ? 'Please choose a color' : null,
                    initialValue: '',
                    onSaved: (val) => setState(() { _chosenValue = val; }),
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
