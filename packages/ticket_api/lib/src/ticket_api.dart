import 'package:ticket_api/ticket_api.dart';
/// {@template ticket_api}
/// The interface and models for an API providing access to tickets.
/// {@endtemplate}
abstract class TicketApi {
  /// {@macro ticket_api}
  const TicketApi();

  Stream<List<Ticket>> getTickets();

  Future<void> saveTicket(Ticket ticket);

  Future<void> deleteTicket(String id);

  Future<int> deleteAll();

  Future<int> clearSelected();

  Future<int> selectAll({required bool  isSelected});

  Future<void> close();
}

class TicketNotFoundException implements Exception {}