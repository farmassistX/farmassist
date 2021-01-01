import 'package:farmassist/app_theme.dart';
import 'package:farmassist/data/IoT/models/telemetry_data.dart';
import 'package:farmassist/data/IoT/repositories/telemetry_data_repository.dart';
import 'package:farmassist/ui/IoT/reload_time.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card_item.dart';
import 'package:farmassist/ui/IoT/telemetry_data_reading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TelemetryDataCard extends StatelessWidget {
  const TelemetryDataCard({Key key, this.cardItem, this.reloadTime})
      : super(key: key);

  final TelemetryDataCardItem cardItem;
  final ReloadTime reloadTime;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TelemetryData>(
      catchError: (_, __) => null,
      create: (context) =>
          context.read<TelemetryDataRepository>().readData(cardItem.data),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 16.0,
              bottom: 18.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cardItem.color1,
                    cardItem.color2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cardItem.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        letterSpacing: 0.0,
                        color: AppTheme.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        child: Text(
                          cardItem.description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            letterSpacing: 0.0,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: 1 == 1 // TODO: temporary dummy placeholder
                                ? Icon(
                                    Icons.warning_rounded,
                                    color: AppTheme.white,
                                    size: 30,
                                  )
                                : null,
                          ),
                          Expanded(
                            child: TelemetryDataReading(
                              reloadTime: reloadTime,
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              cardItem.unit,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                letterSpacing: 0.0,
                                color: AppTheme.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 4.0,
            right: 20.0,
            height: 80,
            width: 80,
            child: Image.asset(cardItem.imagePath),
          ),
        ],
      ),
    );
  }
}
