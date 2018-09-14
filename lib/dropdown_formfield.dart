import 'package:flutter/material.dart';

class DropdownFormField<T> extends StatefulWidget {
  final String hint;
  dynamic value;
  final List<T> items;
  final Function onChanged;
  final Function validator;
  final Function onSaved;
  dynamic initialValue;


  DropdownFormField({
    this.hint,
    dynamic value,
    this.items,
    this.onChanged,
    this.validator,
    dynamic initialValue,
    this.onSaved,
  }) {
    this.value = items.contains(value) ? value : null;
    this.initialValue = items.contains(value) ? value : null;
  }

  @override
  State<StatefulWidget> createState() {
    return _DropdownFormField<T>();
  }
}

class _DropdownFormField<T> extends State<DropdownFormField<T>> {

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: widget.initialValue,
      onSaved: (val) => widget.onSaved,
      validator: widget.validator,
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: Icon(Icons.color_lens),
            labelText: widget.hint,
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: widget.value == '' || widget.value == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: widget.value,
              isDense: true,
              onChanged: (dynamic newValue) {
                state.didChange(newValue);
                widget.onChanged(newValue);
              },
              items: widget.items.map((dynamic value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}