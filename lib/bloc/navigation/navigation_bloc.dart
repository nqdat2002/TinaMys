import 'package:bloc/bloc.dart';
import 'package:tinamys/bloc/navigation/navigation_event.dart';
import 'package:tinamys/bloc/navigation/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState>{
  NavigationBloc() : super(const Opened(pageIndex: 0));

  @override
  Stream<NavigationState> mapEventToState (NavigationEvent event) async*{
    if (event is Navigate){
      yield Opened(pageIndex: event.pageIndex);
    }
  }
}