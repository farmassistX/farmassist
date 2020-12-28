import 'package:farmassist/ui/IoT/reload_bar.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card_item.dart';
import 'package:farmassist/ui/widgets/tab_page.dart';
import 'package:flutter/material.dart';

class IoTMonitoringPage extends TabPage {
  const IoTMonitoringPage({Key key, @required String pageTitle})
      : super(key: key, pageTitle: pageTitle);

  @override
  _IoTMonitoringPageState createState() => _IoTMonitoringPageState();
}

class _IoTMonitoringPageState extends TabPageState<IoTMonitoringPage> {
  List<TelemetryDataCardItem> _cardItems = TelemetryDataCardItem.cardItems;

  @override
  void initState() {
    tabListView.add(ReloadBar());
    _cardItems.forEach((i) {
      tabListView.add(TelemetryDataCard(cardItem: i));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget buildTabListView() {
    return super.buildTabListView();
  }
}
