import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:ah_test/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    final tHasConnectionFuture = Future.value(true);

    setUp(() {
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFuture);
    });
    test('should forward the call to dataConnectionChecker.hasConnection',
        () async {
      final result = networkInfoImpl.isConnected();

      verify(() => mockDataConnectionChecker.hasConnection)
          .called(greaterThan(0));

      expect((await result), (await tHasConnectionFuture));
    });
  });
}
