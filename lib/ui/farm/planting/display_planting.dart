import 'package:farmassist/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class DisplayPlanting extends StatefulWidget {
  final String plantName;
  final String plantNo;
  final String plantDate;
  final double plantEstimate;

  DisplayPlanting({
    this.plantName,
    this.plantNo,
    this.plantDate,
    this.plantEstimate
  });

  @override
  _DisplayPlantingState createState() => _DisplayPlantingState(name:plantName, no:plantNo, date:plantDate, estimate:plantEstimate);
}

class _DisplayPlantingState extends State<DisplayPlanting> {
  final String name;
  final String no;
  final String date;
  final double estimate;

  _DisplayPlantingState({
    this.name,
    this.no,
    this.date,
    this.estimate
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          leading: GFIconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            type: GFButtonType.transparent,
          ),
          title: Text("View Planting Entry",
            style: TextStyle(
              color: AppTheme.nearlyWhite,
            ),),
          backgroundColor: AppTheme.pastelGreen,
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
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            readOnly: true,
                            initialValue: name,
                            name: 'plantName',
                            decoration: InputDecoration(
                              labelText: "Plant Name",
                              icon: Icon(Icons.local_florist_outlined),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            readOnly: true,
                            name: 'plantNumber',
                            initialValue: no,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "No. of Plants",
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            readOnly: true,
                            name: 'plantNumber',
                            initialValue: date,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderSlider(
                            enabled: false,
                            name: 'plantEstimated',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.min(context, 1),
                            ]),
                            min: 1.0,
                            max: 12.0,
                            initialValue: estimate,
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
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
