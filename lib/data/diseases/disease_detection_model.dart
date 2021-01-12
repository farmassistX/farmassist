import 'package:farmassist/data/diseases/classifier.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class DiseaseDetectionModel extends Classifier {
  DiseaseDetectionModel({int numThreads: 1}) : super(numThreads: numThreads);

  @override
  String get modelName => 'model.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}
