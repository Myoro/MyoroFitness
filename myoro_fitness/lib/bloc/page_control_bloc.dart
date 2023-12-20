import "package:flutter_bloc/flutter_bloc.dart";

enum PageControlEnum { tracking, calories, settings }

abstract class PageControlEvent {}
class ChangePageEvent extends PageControlEvent {
  final PageControlEnum page;
  ChangePageEvent(this.page);
}

class PageControlState {
  final PageControlEnum currentPage;
  PageControlState(this.currentPage);
}

class PageControlBloc extends Bloc<PageControlEvent, PageControlState> {
  PageControlBloc() : super(PageControlState(PageControlEnum.calories)) {
    on<ChangePageEvent>((event, emit) => emit(PageControlState(event.page)));
  }
}