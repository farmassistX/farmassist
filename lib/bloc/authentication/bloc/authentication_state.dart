part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.appUser = AppUser.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(AppUser appUser)
      : this._(status: AuthenticationStatus.authenticated, appUser: appUser);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final AppUser appUser;

  @override
  List<Object> get props => [status, appUser];
}
