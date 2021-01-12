import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

import '../../../app_theme.dart';

class DisplayHarvesting extends StatefulWidget {
  final String documentID;
  final String plantName;
  final String plantNo;
  final String plantDate;
  final double plantEstimate;
  final String plantHarvest;
  final String plantQuantity;
  final int plantMonth;

  DisplayHarvesting(
      {this.documentID,
      this.plantName,
      this.plantNo,
      this.plantDate,
      this.plantEstimate,
      this.plantHarvest,
      this.plantMonth,
      this.plantQuantity});

  @override
  _DisplayHarvestingState createState() => _DisplayHarvestingState(
        name: plantName,
        no: plantNo,
        date: plantDate,
        estimate: plantEstimate,
        harvest: plantHarvest,
        id: documentID,
        month: plantMonth,
        quantity: plantQuantity,
      );
}

class _DisplayHarvestingState extends State<DisplayHarvesting> {
  final _formKey = GlobalKey<FormBuilderState>();

  final String id;
  final String name;
  final String no;
  final String date;
  final double estimate;
  final String harvest;
  final int month;
  final String quantity;

  _DisplayHarvestingState(
      {this.id,
      this.name,
      this.no,
      this.date,
      this.estimate,
      this.harvest,
      this.month,
      this.quantity});

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
          title: Text(
            "View Harvesting Entry",
            style: TextStyle(
              color: AppTheme.nearlyWhite,
            ),
          ),
          backgroundColor: AppTheme.pastelGreen,
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              new Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                    FormBuilder(
                      key: _formKey,
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
                            name: 'plantDate',
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
                              labelText: 'Estimated Harvest Date (weeks)',
                              icon: Icon(Icons.timelapse),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'harvestQuantity',
                            readOnly: true,
                            initialValue: quantity,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Harvest Yield",
                              icon: Icon(Icons.format_list_numbered),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'harvestDate',
                            readOnly: true,
                            initialValue: harvest,
                            decoration: InputDecoration(
                              labelText: 'Harvest Date',
                              icon: Icon(Icons.date_range),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
