import 'dart:async';

import 'package:farmassist/data/farm/resources/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nEvent.dart';
import 'nState.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Repository repository;

  NewsBloc({this.repository}) : super(null);

  @override
  NewsState get initialState => Loading();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is Fetch) {
      try {
        yield Loading();
        final items = await repository.fetchAllNews(category: event.type);
        yield Loaded(items: items, type: event.type);
      } catch (_) {
        yield Failure();
      }
    }
  }
}
