import 'package:farmassist/data/farm/models/News.dart';
import 'package:farmassist/ui/farm/news_details/bloc/bloc.dart';
import 'package:farmassist/ui/farm/news_details/newsDetailPage.dart';
import 'package:farmassist/ui/widgets/news_customWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../app_theme.dart';

class NewsCard extends StatelessWidget {
  final Article artical;
  final bool isVideoNews;
  final String type;
  const NewsCard(
      {Key key, this.artical, this.isVideoNews = false, this.type = ''})
      : super(key: key);
  Widget _playWidget(BuildContext context) {
    return SizedBox(
        height: 20,
        child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
                height: 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).bottomAppBarColor),
                child: Icon(
                  Icons.play_arrow,
                  color: Theme.of(context).disabledColor,
                  size: 3,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          BlocProvider.of<DetailBloc>(context)
              .add(SelectNewsForDetail(article: artical));
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  child: NewsDetailPage()));
          ;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Container(
                              color: Colors.grey,
                              child: artical.urlToImage == null ||
                                      artical.urlToImage.isEmpty
                                  ? Container()
                                  : customImage(artical.urlToImage,
                                      fit: BoxFit.cover)),
                          isVideoNews ? _playWidget(context) : Container()
                        ],
                      ))),
              SizedBox(width: 10),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  Container(
                    height: 52,
                    child: Text(
                      artical.title,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: Text(
                          '$type',
                          style:
                              AppTheme.headline6.copyWith(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(artical.getDateOnly(),
                            style: AppTheme.subtitle2),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
