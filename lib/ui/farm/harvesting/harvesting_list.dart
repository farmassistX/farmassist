import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmassist/data/farm/utils/weather_strings.dart';
import 'package:farmassist/ui/farm/harvesting/display_harvesting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:page_transition/page_transition.dart';

import '../../../app_theme.dart';

class HarvestList extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  _HarvestListState createState() => _HarvestListState();
}

class _HarvestListState extends State<HarvestList> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _monthOptions =
    ['January', 'February', 'March', 'April', 'May','June','July','August','September','October','November','December'];
  var _option;
  String uid = "";

  convert(month){
    return (_monthOptions.indexOf(month)+1);
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
                    User user = _auth.currentUser;
                    setState(() {
                      _option = value;
                      uid = user.uid;
                    });
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
        title: Text("View Harvesting Entry",
          style: TextStyle(
            color: AppTheme.nearlyBlack,
          ),),
        backgroundColor: AppTheme.nearlyWhite,
      ),
      body: _option!=null?(
          StreamBuilder<QuerySnapshot>(
            stream: widget.db.collection('harvesting').doc(uid).collection('month')
                .where('month', isNotEqualTo: -99).where('month',isEqualTo: convert(_option))
                .snapshots(),
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
                        String date = snapshot.data.docs[index]['harvestDate'];
                        String harvest = snapshot.data.docs[index]['harvestDate'];
                        String number = snapshot.data.docs[index]['noOfPlants'];
                        double est = snapshot.data.docs[index]['estimatedHarvest'];
                        String yield = snapshot.data.docs[index]['harvestQuantity'];
                        return GFListTile(
                          padding: EdgeInsets.all(10.0),
                          titleText: Strings.toTitleCase(itemTitle),
                          subtitleText: date,
                          color: Colors.blueGrey[100],
                          icon: Icon(Icons.chevron_right),
                          onTap: (){
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRightWithFade,
                                    child: DisplayHarvesting(
                                      plantName: itemTitle,
                                      plantDate: date,
                                      plantQuantity: yield,
                                      plantEstimate: est,
                                      plantNo: number,
                                      plantHarvest: harvest,
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
