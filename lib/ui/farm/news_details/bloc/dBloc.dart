import 'dEvent.dart';
import 'dState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farmassist/data/farm/models/News.dart';

class DetailBloc extends Bloc<NewsDetailEvent,DetailState>{
  DetailBloc(DetailState initialState) : super(initialState);

  @override
  DetailState get initialState => LoadingDetail();

  @override
  Stream<DetailState> mapEventToState(NewsDetailEvent event)async* {
    if(event is SelectNewsForDetail){
      try {
        yield LoadedArticle(selectedArticle: event.article);
      } catch (_) {
        yield FailureDetail();
      }
    }
  }
}