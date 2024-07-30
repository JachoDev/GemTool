// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:tickets_repository/tickets_repository.dart';

void main() {
  group('TicketsRepository', () {
    test('can be instantiated', () {
      expect(TicketsRepository(), isNotNull);
    });
  });
}
