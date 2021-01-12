import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/diseases/diagnosis.dart';
import 'package:farmassist/ui/diseases/disease_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiseaseCard extends StatelessWidget {
  const DiseaseCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Diagnosis diagnosis = context.watch<Diagnosis>();
    String disease = diagnosis.disease;
    String confidence = diagnosis.confidence;
    int i = 0;

    for (int j = 0; j < 8; j++) {
      if (DiseaseCardItem.diseaseItem[j].diseaseName == disease) i = j;
    }

    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 23.0,
              right: 23.0,
              top: 15.0,
              bottom: 18.0,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        DiseaseCardItem.diseaseItem[i].color1,
                        DiseaseCardItem.diseaseItem[i].color2,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.grey.withOpacity(0.6),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 230,
                          child: Text(
                            DiseaseCardItem.diseaseItem[i].diseaseName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              letterSpacing: 0.0,
                              color: AppTheme.darkerText,
                            ),
                          ),
                        ),
                        Container(
                          child: confidence == null
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: FractionallySizedBox(
                                    widthFactor: 0.9,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: AppTheme.white.withOpacity(0.4),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 6.0,
                                          left: 6.0,
                                          top: 12,
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          'Confidence: $confidence%',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            letterSpacing: 0.18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Text(
                              DiseaseCardItem.diseaseItem[i].action,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.0,
                                color: AppTheme.dark_grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            right: 20.0,
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Text(
                              DiseaseCardItem.diseaseItem[i].treatment,
                              textAlign: TextAlign.left,
                              style: AppTheme.bodyText1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 17.5,
            height: 80,
            width: 80,
            child: Image.asset(DiseaseCardItem.diseaseItem[i].imagePath),
          ),
        ],
      ),
    );
  }
}
