import 'package:flutter_test/flutter_test.dart';
import 'package:frigoligo/services/remote_sync.dart';
import 'package:frigoligo/ui/home/controllers/listing_container_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteSyncer extends Mock implements RemoteSyncer {}

void main() {
  group('ListingContainerController', () {
    late MockRemoteSyncer mockRemoteSyncer;
    late ListingContainerController controller;

    setUp(() {
      mockRemoteSyncer = MockRemoteSyncer();
      controller = ListingContainerController(remoteSyncer: mockRemoteSyncer);
    });

    test('refresh', () async {
      when(
        () => mockRemoteSyncer.synchronize(withFinalRefresh: true),
      ).thenAnswer((_) async => {});

      await controller.refresh();

      verify(
        () => mockRemoteSyncer.synchronize(withFinalRefresh: true),
      ).called(1);
    });
  });
}
