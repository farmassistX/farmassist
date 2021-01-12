import 'dart:ui';

class DiseaseCardItem {
  DiseaseCardItem({
    this.diseaseName,
    this.action,
    this.treatment,
    this.color1,
    this.color2,
    this.imagePath,
  });

  final String diseaseName;
  final String action;
  final String treatment;
  final Color color1;
  final Color color2;
  final String imagePath;

  static List<DiseaseCardItem> diseaseItem = [
    DiseaseCardItem(
      diseaseName: 'DISEASE',
      action: 'Action/Treatment Information',
      treatment: 'Snap or choose an image now for disease detection!',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'TOMATO LEAF MOLD',
      action: 'Treatment:',
      treatment:
          'Method 1:\nLet the plants air out or expose to dry air conditions.\n\nMethod 2:\nSpray the plants with fungicide sprays (Recommended: Calcium chloride sprays) and make sure to cover all parts of the plant that is above ground, focusing specifically on the underside of leaves.',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'STRAWBERRY LEAF SCORCH',
      action: 'Treatment:',
      treatment:
          'Method 1:\nLet the plant dry out by altering the watering practices and allowing for dryer conditions.\n\nMethod 2:\nTreat the plant with organic fungicides. (Captan 50 WP & Copper compounds)\n\nNote:\nCan be prevented most effectively with the use of resistant varieties. (Allstar, Jewell, Midway & etc.)',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'TOMATO MOSAIC VIRUS',
      action: 'Actions:',
      treatment:
          'Note that there is NO cure for this viral disease!\n\nAction 1:\nRemove and destroy all infected plant.\n\nAction 2:\nSpot treat with least-toxic, natural pest control products (Safer Soap & Bon-Neem) to reduce the disease carrying insects.\n\nAction 3:\nPlant resistant varieties or purchase transplants from a reputable source.\n\nAction 4:\nWash your hands frequently and disinfect garden tools and equipment to reduce contamination risk.',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'CORN COMMON RUST',
      action: 'Treatment:',
      treatment:
          'Method 1:\nPlant resistant hybrids such as commercial corn.\n\nMethod 2:\nGo for tillage and crop rotation\n\nMethod 3:\nTreat with fungicide such as foliar, Quilt and Quadris.',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'CORN GRAY LEAF SPOT',
      action: 'Treatment:',
      treatment:
          'Method 1:\nGo for crop rotation and tillage will help to reduce inoculum levels in surface residues.\n\nMethod 2:\nPlant resistant varieties.\n\nMethod 3:\nTreat with fungicide such as azoxystrobin with propiconazole, pyraclostrobin and prothioconazole.\n',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'POTATO EARLY BLIGHT',
      action: 'Actions:',
      treatment:
          'Note that there is NO cure for blight on plants.\n\nAction 1:\nRemove and destroy all infected plant.\n\nAction 2:\nDisinfect garden tools and equipment to prevent further spread of blight.\n\nAction 3:\nPlant resistant varieties or practice crop rotation to prevent blight.\n\nAction 4:\nFor best control, apply copper-based fungicides earlier before wet weather condition happens.',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/treatment.png',
    ),
    DiseaseCardItem(
      diseaseName: 'HEALTHY',
      action: 'Condition:',
      treatment:
          'Your plant is healthy!\nHowever, do remember to practice good farming habits as prevention is the best cure diseases!',
      color1: const Color(0XFFFFF176),
      color2: const Color(0XFF69F0AE),
      imagePath: 'assets/images/healthy.png',
    ),
  ];
}
