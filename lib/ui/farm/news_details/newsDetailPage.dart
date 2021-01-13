import 'package:farmassist/data/farm/models/News.dart';
import 'package:farmassist/ui/farm/news/bloc/bloc.dart';
import 'package:farmassist/ui/widgets/news_customWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_theme.dart';
import 'bloc/bloc.dart';

class NewsDetailPage extends StatelessWidget {
  Widget _headerNews(BuildContext context, Article article) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Hero(
          tag: 'headerImage',
          child: article.urlToImage == null || article.urlToImage.isEmpty
              ? Container()
              : customImage(article.urlToImage),
        ),
        Container(
          padding: EdgeInsets.only(left: 0, right: 10, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _body(BuildContext context, Article article) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _headerNews(context, article),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(article.title, style: AppTheme.headline5),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(article.author ?? '', style: AppTheme.subtitle2),
                  SizedBox(
                    width: 10,
                  ),
                  Text(article.getTime(), style: AppTheme.subtitle2),
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Text(article.content ?? '', style: AppTheme.bodyText1)
            ],
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state == null) {
              return Center(child: Text('Null bloc'));
            }
            if (state is Failure) {
              return Center(child: Text('Something went wrong'));
            }
            if (state is LoadedArticle) {
              if (state.selectedArticle == null) {
                return Text('No content avilable');
              } else {
                return _body(
                  context,
                  state.selectedArticle,
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )));
  }
}
