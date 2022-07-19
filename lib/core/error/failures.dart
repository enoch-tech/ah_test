import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => ['Server error 404'];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => ['No cached data found'];
}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => ['Network Failure'];
}
