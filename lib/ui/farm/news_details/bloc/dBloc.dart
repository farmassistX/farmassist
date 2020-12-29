import 'package:flutter_bloc/flutter_bloc.dart';

import 'dEvent.dart';
import 'dState.dart';

class DetailBloc extends Bloc<NewsDetailEvent, DetailState> {
  DetailBloc(DetailState initialState) : super(initialState);

  @override
  DetailState get initialState => LoadingDetail();

  @override
  Stream<DetailState> mapEventToState(NewsDetailEvent event) async* {
    if (event is SelectNewsForDetail) {
      try {
        yield LoadedArticle(selectedArticle: event.article);
      } catch (_) {
        yield FailureDetail();
      }
    }
  }
}
