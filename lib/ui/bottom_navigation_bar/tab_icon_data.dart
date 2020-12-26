import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath,
    this.index,
    this.selectedImagePath,
    this.isSelected,
    this.animationController,
    this.label,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  String label;
  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/farm_management_tab.png',
      selectedImagePath: 'assets/images/farm_management_tab_selected.png',
      index: 0,
      isSelected: true,
      label: 'Manage',
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/IoT_monitoring_tab.png',
      selectedImagePath: 'assets/images/IoT_monitoring_tab_selected.png',
      index: 1,
      isSelected: false,
      label: 'Monitor',
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/disease_detection_tab.png',
      selectedImagePath: 'assets/images/disease_detection_tab_selected.png',
      index: 2,
      isSelected: false,
      label: 'Detect',
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/user_profile_tab.png',
      selectedImagePath: 'assets/images/user_profile_tab_selected.png',
      index: 3,
      isSelected: false,
      label: 'Me',
      animationController: null,
    ),
  ];
}
