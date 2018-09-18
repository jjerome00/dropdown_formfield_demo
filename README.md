# dropdown_formfield_demo

A demo of a DropDown Widget in flutter that can be validated.

![screenshot](validating-dropdown-demo.gif)

> The Flutter team is supposed to release a full-featured dropdown at some point in the future.  So be sure to check on this if you intend to use this in production code.

## Background

I wanted to validate a dropdown, and could not find any good examples of how to do it.

Flutter provides a few convenience widgets that help you validate fields on a form. A good example is a `TextFormField`. It wraps a `TextField` with a `FormField`, providing an easier way to validate text.

For whatever reason, they didn't provide a convenience widget for the `DropDown` widget. So that's what I did.

### This demo is actually 2 demos.

`main.dart` - a simple form that wraps a DropDown in a FormField.  Everything you need is right there to copy and customize.

`main_formfield.dart` - I made a custom Widget, called `DropdownFormField` that does all the FormField stuff for you. For the most part - your results may vary.

* Both examples include a `TextFormField` widget


> If you find a bug or know of a better way to achieve the result, please make a Pull Request!

## Running the Demos

Both demos have their own file to use as starting point.  

From a terminal:   
Main Demo: `flutter run ./lib/main.dart`   
FormField Demo: `flutter run ./lib/main_formfield.dart`




Special thanks to https://github.com/jebright/flutter_form_app, who got me started with validating forms.
