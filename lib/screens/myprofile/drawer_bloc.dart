import 'notification.dart';
import 'userprofile.dart';
import 'package:bloc/bloc.dart';
 
enum DrawerEvents { ProfileEvent, NotificationEvent }

abstract class DrawerStates {}

class DrawerBloc extends Bloc<DrawerEvents, DrawerStates> {

  @override
  DrawerStates get initialState => UserProfileScreen();

  @override
  Stream<DrawerStates> mapEventToState(DrawerEvents event) async* {
    switch (event) {
      case DrawerEvents.ProfileEvent:
        yield UserProfileScreen();
        break;
      case DrawerEvents.NotificationEvent:
        yield NotificationScreen();
        break;
    }
  }
}
