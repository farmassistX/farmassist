import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farmassist/data/farm/models/News.dart';
import 'package:farmassist/ui/widgets/news_customWidget.dart';
import 'package:farmassist/ui/farm/news_details/bloc/bloc.dart';
import 'package:farmassist/app_theme.dart';
import 'bloc/bloc.dart';
import 'Widget/newsCard.dart';

class HomePage extends StatelessWidget {
  Widget _headerNews(Article article) {
    return Builder(
      builder: (context) {
        return InkWell(
            onTap: () {

            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Hero(
                  tag: 'headerImage',
                  child: customImage(article.urlToImage),
                ),
                Container(
                  padding:
                  EdgeInsets.only(left: 20, right: 10, bottom: 20, top: 20),
                  color: Colors.black26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(article.title,
                          style: AppTheme.headline4.copyWith(
                              color: Theme.of(context).colorScheme.onSurface)),
                      Text(article.getTime(),
                          style: AppTheme.subtitle2
                              .copyWith(color: Theme.of(context).disabledColor))
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget _body(
      BuildContext context,
      List<Article> list, {
        String type,
      }) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            '${type.toUpperCase()} NEWS',
            style: AppTheme.headline5
                .copyWith(color: Theme.of(context).colorScheme.primaryVariant),
          ),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: _headerNews(list.first),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => NewsCard(
                  artical: list[index],
                  type: type.toUpperCase(),
                ),
                childCount: list.length))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).backgroundColor,
        statusBarColor: Theme.of(context).backgroundColor));
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
            child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
              if (state == null) {
                return Center(child: Text('Null block'));
              }
              if (state is Failure) {
                return Center(child: Text('Something went wrong'));
              }
              if (state is Loaded) {
                if (state.items == null || state.items.isEmpty) {
                  return Text('No content avilable');
                } else {
                  return _body(context, state.items, type: state.type);
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })));
  }
}