import 'package:farmassist/data/diseases/disease_detection_model.dart';
import 'package:farmassist/data/diseases/classifier.dart';
import 'package:farmassist/ui/diseases/diagnosis.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';


class ViewImageRegion extends StatefulWidget {

  const ViewImageRegion({
    @required
    this.getDisease
  });

  final Diagnosis getDisease;

  @override
  _ViewImageRegionState createState() => _ViewImageRegionState();
}

class _ViewImageRegionState extends State<ViewImageRegion> {
  PickedFile _image;
  File plantImage;
  dynamic _pickImageError;
  Classifier _classifier;
  var logger = Logger();
  Category category;
  String diseaseLabel;
  String confidence;

  void _onImageButtonPressed (ImageSource source, {BuildContext context}) async {
      try {
        final pickedFile = await ImagePicker().getImage(
            source: source,
        );
        _image = pickedFile;
        final File _plantImage = File (_image.path);
        File croppedFile = await ImageCropper.cropImage(
            sourcePath: _plantImage.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
        );
        //setState(() {
          plantImage = croppedFile;
        //});
        _predict(plantImage);
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }

  }

  @override
  void initState() {
    super.initState();
    _classifier = DiseaseDetectionModel();
    diseaseLabel = '';
    confidence = '';
  }

  void _predict(File image) async {
    img.Image imageInput = img.decodeImage(image.readAsBytesSync());
    var pred = _classifier.predict(imageInput);

    setState(() {
      this.category = pred;
    });

    diseaseLabel = category.label;
    confidence = category.score.toStringAsFixed(3);

    if (category.score > 0.5){
      print ('confidence: ');
      print (category.score);
      Future.delayed(
        Duration.zero,
            () => widget.getDisease.update(category.label),
      );
    } else {
      Future.delayed(
        Duration.zero,
            () => widget.getDisease.update('Healthy'),
      );
    }
  }

  void _cancelImage() {
      setState(() {
        plantImage = null;
      });
      Future.delayed(
        Duration.zero,
            () => widget.getDisease.update('Disease'),
      );
      diseaseLabel = '';
      confidence = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center (
        child: Column (
          children: <Widget> [
            Container(
                color: Colors.grey[300],
                height: 224.0,
                width: 224.0,
                child: Center (
                  child: plantImage == null ? Text (
                    'No image selected.',
                    textAlign: TextAlign.center,
                  )
                      : Image.file(
                        plantImage,
                        height: 224.0,
                        width: 225.0,
                        fit: BoxFit.fill,
                  ),
                ),
            ),
            Container(
              height: 90.0,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipOval (
                    child: Material(
                      color: Colors.teal[100],
                      child: InkWell(
                        splashColor: Colors.cyan[100],
                        child: SizedBox (width: 56, height: 56, child: Icon (Icons.add_a_photo_outlined)),
                        onTap: () {
                          _onImageButtonPressed(ImageSource.camera, context: context);
                          },
                      ),
                    ),
                  ),
                  ClipOval (
                    child: Material(
                      color: Colors.teal[100],
                      child: InkWell(
                        splashColor: Colors.cyan[100],
                        child: SizedBox (width: 56, height: 56, child: Icon (Icons.image_outlined)),
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery, context: context);
                        },
                      ),
                    ),
                  ),
                  ClipOval (
                    child: Material(
                      color: Colors.teal[100],
                      child: InkWell(
                        splashColor: Colors.cyan[100],
                        child: SizedBox (width: 56, height: 56, child: Icon (Icons.image_not_supported_outlined)),
                        onTap: () {
                          _cancelImage();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container (
              child: Column (
                children: <Widget>[
                  Text(
                    // category != null ? category.label : '',
                    diseaseLabel,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                SizedBox(
                height: 8,
                ),
                  Text(
                    // category != null
                    //     ? 'Confidence: ${category.score.toStringAsFixed(3)}'
                    //     : '',
                    confidence,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}