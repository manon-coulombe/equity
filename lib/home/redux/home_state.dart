part of 'home_redux.dart';

class HomeState extends Equatable {
  final Status status;
  final List<Compte> comptes;

  const HomeState({
    this.status = Status.NOT_LOADED,
    this.comptes = const [],
  });

  HomeState clone({
    Status? status,
    List<Compte>? comptes,
  }) {
    return HomeState(
      status: status ?? this.status,
      comptes: comptes ?? this.comptes,
    );
  }

  @override
  List<Object?> get props => [status, comptes];
}