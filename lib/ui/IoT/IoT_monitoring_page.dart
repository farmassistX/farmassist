import 'package:farmassist/data/IoT/repositories/telemetry_data_repository.dart';
import 'package:farmassist/ui/IoT/reload_bar.dart';
import 'package:farmassist/ui/IoT/reload_time.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card_item.dart';
import 'package:farmassist/ui/widgets/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class IoTMonitoringPage extends TabPage {
  const IoTMonitoringPage({Key key, @required String pageTitle})
      : super(key: key, pageTitle: pageTitle);

  @override
  _IoTMonitoringPageState createState() => _IoTMonitoringPageState();
}

class _IoTMonitoringPageState extends TabPageState<IoTMonitoringPage> {
  final List<TelemetryDataCardItem> _cardItems =
      TelemetryDataCardItem.cardItems;
  final ReloadTime _reloadTime = ReloadTime();

  @override
  void initState() {
    tabListView.add(ReloadBar());
    _cardItems.forEach((i) {
      tabListView.add(TelemetryDataCard(
        cardItem: i,
        reloadTime: _reloadTime,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TelemetryDataRepository>(
      create: (_) => TelemetryDataRepository(),
      child: ChangeNotifierProvider<ReloadTime>.value(
        value: _reloadTime,
        child: super.build(context),
      ),
    );
  }

  @override
  Widget buildTabListView() {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 70 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(children: tabListView),
    );
  }
}
