 import 'dart:async';

import 'package:farmassist/data/farm/utils/weather_strings.dart';
import 'package:farmassist/ui/farm/planting/display_planting.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:page_transition/page_transition.dart';

import '../../../app_theme.dart';

class PlantingList extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  _PlantingListState createState() => _PlantingListState();
}

class _PlantingListState extends State<PlantingList> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  StreamController _streamController;
  Stream _stream;
  final _monthOptions = ["January","February"];
  var _option;
  String uid = "";

  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: FormBuilderDropdown(
                    name: 'month',
                    // initialValue: "January",
                    decoration: InputDecoration(
                      labelText: 'Month',
                    ),
                    onChanged: (value){
                      print(_option);
                      User user = _auth.currentUser;
                      setState(() {
                        _option = value;
                        uid = user.uid;
                      });
                      print(_option);
                      print(uid);
                    },
                    allowClear: true,
                    hint: Text('Select Month'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: _monthOptions
                        .map((month) => DropdownMenuItem(
                      value: month,
                      child: Text('$month'),
                    ))
                        .toList(),
                  ),
              )
            ],
          ),
        ),
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
        title: Text("View Planting Entry",
          style: TextStyle(
            color: AppTheme.nearlyBlack,
          ),),
        backgroundColor: AppTheme.nearlyWhite,
      ),
      body: _option!=null?(
        StreamBuilder<QuerySnapshot>(
          stream: widget.db.collection("Planting").doc(uid).collection(_option).orderBy('date', descending:true).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) {
              return Text('Loading...');
            }
            return Column(
              children: [
                new Expanded(child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index){
                      String itemTitle = snapshot.data.docs[index]['name'];
                      String date = snapshot.data.docs[index]['date'];
                      String number = snapshot.data.docs[index]['noOfPlants'];
                      double est = snapshot.data.docs[index]['estimatedHarvest'];
                      return GFListTile(
                        padding: EdgeInsets.all(10.0),
                        titleText: Strings.toTitleCase(itemTitle),
                        subtitleText: date,
                        color: Colors.blueGrey[100],
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRightWithFade,
                                  child:  DisplayPlanting(
                                    plantName: itemTitle,
                                    plantNo: number,
                                    plantDate: date,
                                    plantEstimate: est,
                                  )
                              ));
                        },
                      );
                    }))
              ],
            );
          },
        )
      ):Container(
        child: Center(
          child: Text("Please select a month."),
        ),
      ),
    );
  }
}

