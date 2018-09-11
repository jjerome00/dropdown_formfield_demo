import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class Contact {
  String name;
  String favoriteColor = '';
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Validating DropDown',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Validating DropDown'),
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _color = '';
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  Contact newContact = new Contact();

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate() ) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called, newContact is:');
      print('Email: ${newContact.name}');
      print('Favorite Color: ${newContact.favoriteColor}');
      print('========================================');
      print('');
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: false,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    validator: (val) => val.isEmpty ? 'A name is required' : null,
                    onSaved: (val) => newContact.name = val,
                  ),
                  FormField<String>(
                    initialValue: _color,
                    onSaved: (val) => newContact.favoriteColor = val,
                    validator: (val) => (val == null || val.isEmpty) ? 'Please choose a color' : null,
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: Icon(Icons.color_lens),
                          labelText: 'Color',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: state.value == '' || state.value == null,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.value,
                            isDense: true,
                            onChanged: (String newValue) {
                              state.didChange(newValue);
                            },
                            items: _colors.map((String value) {
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
                      padding: const EdgeInsets.all(40.0),
                      child: RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }

}
