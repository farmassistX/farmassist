import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:farmassist/data/authentication/models/user.dart';
import 'package:farmassist/data/authentication/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _appUserSubscription = _authenticationRepository.appUser.listen(
      (appUser) => add(AuthenticationUserChanged(appUser)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<AppUser> _appUserSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _appUserSubscription?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
    return event.appUser != AppUser.empty
        ? AuthenticationState.authenticated(event.appUser)
        : const AuthenticationState.unauthenticated();
  }
}
