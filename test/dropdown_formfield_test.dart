import 'package:dropdown_formfield_demo/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  List<String> _items = <String>['', 'garfield', 'odie', 'jon', ];
  String _chosenItem;

  testWidgets('Displays validation error if no value is selected', (WidgetTester tester) async {

    String expectedValidationMessage = "Please choose a character";

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
          return MaterialApp(
              home: Scaffold(
                  body: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        DropdownFormField<String>(
                          hint: 'Pick one',
                          value: _chosenItem,
                          items: _items.toList(),
                          onChanged: (val) => setState(() {
                            _chosenItem = val;
                          }),
                          validator: (val) => (val == null || val.isEmpty) ? expectedValidationMessage : null,
                          initialValue: '',
                          onSaved: (val) => setState(() {
                            _chosenItem = val;
                          }),
                        ),
                        RaisedButton(
                          key: Key('submit-button'),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            print("valid!");
                          }
                        ),
                      ])
                  )
              )
          );
        })
    );

    expect(_chosenItem, null);
    await tester.tap(find.byKey(Key('submit-button')));
    await tester.pump();

    expect(find.text(expectedValidationMessage), findsOneWidget);

  });

  testWidgets('Does not crash when given an initial value that does not exist', (WidgetTester tester) async {

    String _initialValue = "nermal";

    await tester.pumpWidget(
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
              return MaterialApp(
                  home: Scaffold(
                      body: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            DropdownFormField<String>(
                              hint: 'Pick one',
                              value: _chosenItem,
                              items: _items.toList(),
                              onChanged: (val) => setState(() {
                                _chosenItem = val;
                              }),
                              validator: (val) => (val == null || val.isEmpty) ? 'choose one' : null,
                              initialValue: _initialValue,
                              onSaved: (val) => setState(() {
                                _chosenItem = val;
                              }),
                            ),
                            RaisedButton(
                                key: Key('submit-button'),
                                onPressed: () {
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  _formKey.currentState.save();
                                  print("valid!");
                                }
                            ),
                          ])
                      )
                  )
              );
            })
    );

    expect(_chosenItem, null);
    await tester.tap(find.byKey(Key('submit-button')));
    await tester.pump();

    expect(find.text("choose one"), findsOneWidget);

  });

}
