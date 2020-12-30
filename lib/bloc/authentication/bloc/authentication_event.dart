part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.appUser);

  final AppUser appUser;

  @override
  List<Object> get props => [appUser];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
