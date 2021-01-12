import 'package:farmassist/ui/widgets/tab_page.dart';
import 'package:farmassist/ui/diseases/view_image_region.dart';
import 'package:farmassist/ui/diseases/disease_card_item.dart';
import 'package:farmassist/ui/diseases/disease_card.dart';
import 'package:farmassist/ui/diseases/diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DiseaseDetectionPage extends TabPage {
  const DiseaseDetectionPage({Key key, @required String pageTitle})
      : super(key: key, pageTitle: pageTitle);

  @override
  _DiseaseDetectionPageState createState() => _DiseaseDetectionPageState();
}

class _DiseaseDetectionPageState extends TabPageState<DiseaseDetectionPage> {

  final List<DiseaseCardItem> _diseaseItem = DiseaseCardItem.diseaseItem;
  Diagnosis _disease = Diagnosis();

  void initState() {

    tabListView.add(ViewImageRegion(
      getDisease: _disease,
    ));

    tabListView.add(DiseaseCard (
        diseaseItem:
          DiseaseCardItem(
          diseaseName: 'DISEASE',
          action: 'Action/Treament Information',
          treatment: 'Snap or choose an image now for disease detection!',
          color1: const Color(0XFFFFF176),
          color2: const Color (0XFF69F0AE),
          imagePath: 'assets/images/treatment.png',
        ),
        getDisease: _disease,
      ));
    print ('_disease!!!!!');
    print (Diagnosis().getDisease);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Diagnosis>.value(
        value: _disease,
        child: super.build(context),
    );
  }

  @override
  Widget buildTabListView() {
    return super.buildTabListView();
  }
}
