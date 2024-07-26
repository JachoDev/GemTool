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

  Future<int> clearCompleted();

  Future<int> completeAll({required bool  isCompleted});

  Future<void> close();
}

class TicketNotFoundException implements Exception {}