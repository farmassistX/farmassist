import 'package:farmassist/data/farm/repositories/storeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class formStorePlanting extends StatefulWidget {
  @override
  _formStorePlantingState createState() => _formStorePlantingState();
}

class _formStorePlantingState extends State<formStorePlanting> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: GFIconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          type: GFButtonType.transparent,
        ),
        title: Text("Create Planting Entry"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget> [
            new Expanded(
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: <Widget>[
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'plantName',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          decoration: InputDecoration(
                            labelText: "Plant Name",
                            icon: Icon(Icons.local_florist_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'plantNumber',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "No. of Plants",
                            icon: Icon(Icons.format_list_numbered),
                          ),
                        ),
                        SizedBox(height: 10),
                        FormBuilderDateTimePicker(
                          name: 'plantDate',
                          currentDate: DateTime.now(),
                          inputType: InputType.date,
                          initialValue: DateTime.now(),
                          lastDate: DateTime.now(),
                          decoration: InputDecoration(
                            labelText: 'Date',
                            icon: Icon(Icons.date_range),
                          ),
                        ),
                        SizedBox(height: 10),
                        FormBuilderSlider(
                          name: 'plantEstimated',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.min(context, 1),
                          ]),
                          min: 1.0,
                          max: 12.0,
                          initialValue: 5.0,
                          divisions: 11,
                          label: 'Weeks',
                          activeColor: Colors.red,
                          inactiveColor: Colors.pink[100],
                          decoration: InputDecoration(
                            labelText: 'Estimated Harvest Date',
                            icon: Icon(Icons.timelapse),
                          ),
                        ),
                        SizedBox(height: 20),
                        // FormBuilderCheckbox(
                        //   name: 'accept_terms',
                        //   initialValue: false,
                        //   title: RichText(
                        //     text: TextSpan(
                        //       children: [
                        //         TextSpan(
                        //           text: 'I have read and agree to the ',
                        //           style: TextStyle(color: Colors.black),
                        //         ),
                        //         TextSpan(
                        //           text: 'Terms and Conditions',
                        //           style: TextStyle(color: Colors.blue),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   validator: FormBuilderValidators.equal(
                        //     context,
                        //     true,
                        //     errorText:
                        //     'You must accept terms and conditions to continue',
                        //   ),
                        // ),
                        // FormBuilderDropdown(
                        //   name: 'gender',
                        //   decoration: InputDecoration(
                        //     labelText: 'Gender',
                        //   ),
                        //   // initialValue: 'Male',
                        //   allowClear: true,
                        //   hint: Text('Select Gender'),
                        // ),
                        // FormBuilderTypeAhead(
                        //   decoration: InputDecoration(
                        //     labelText: 'Country',
                        //   ),
                        //   name: 'country',
                        //   itemBuilder: (context, country) {
                        //     return ListTile(
                        //       title: Text(country),
                        //     );
                        //   },
                        //   controller: TextEditingController(text: ''),
                        //   initialValue: 'Uganda',
                        // ),
                        // FormBuilderRadioGroup(
                        //   decoration:
                        //   InputDecoration(labelText: 'My chosen language'),
                        //   name: 'best_language',
                        // ),
                        // FormBuilderTouchSpin(
                        //   decoration: InputDecoration(labelText: 'Stepper'),
                        //   name: 'stepper',
                        //   initialValue: 10,
                        //   step: 1,
                        //   iconSize: 48.0,
                        //   addIcon: Icon(Icons.arrow_right),
                        //   subtractIcon: Icon(Icons.arrow_left),
                        // ),
                        // FormBuilderRating(
                        //   decoration: InputDecoration(labelText: 'Rate this form'),
                        //   name: 'rate',
                        //   iconSize: 32.0,
                        //   initialValue: 1.0,
                        //   max: 5.0,
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Colors.red,
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState.reset();
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState.save();
                            if (_formKey.currentState.validate()) {
                              print(_formKey.currentState.value);
                              addData(_formKey.currentState.value);
                            } else {
                              print("validation failed");
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
