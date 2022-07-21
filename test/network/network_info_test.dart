import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ah_test/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl? networkInfoImpl;
  MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker!);
  });

  group('isConnected', () {
    test('should forward the call to dataConnectionChecker.hasConnection', () {
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker!.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      final result = networkInfoImpl!.isConnected;
      verify(mockDataConnectionChecker!.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
