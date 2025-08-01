import 'package:ticket_api/ticket_api.dart';
/// {@template tickets_repository}
/// A repository that handles ticket related requests.
/// {@endtemplate}
class TicketsRepository {
  /// {@macro tickets_repository}
  const TicketsRepository({
    required TicketApi ticketApi,
  }) : _ticketApi = ticketApi;

  final TicketApi _ticketApi;

  Stream<List<Ticket>> getTickets() => _ticketApi.getTickets();

  Stream<List<String>> getApiKey() => _ticketApi.getApiKey();

  Future<void> saveApiKey(String apiKey) => _ticketApi.saveApiKey(apiKey);

  Future<void> deleteApiKey() => _ticketApi.deleteApiKey();

  Future<void> saveTicket(Ticket ticket) => _ticketApi.saveTicket(ticket);

  Future<void> deleteTicket(String id) => _ticketApi.deleteTicket(id);

  Future<int> clearSelected() => _ticketApi.clearSelected();

  Future<int> deleteAll() => _ticketApi.deleteAll();

  Future<int> selectAll({required bool isSelected}) =>
      _ticketApi.selectAll(isSelected: isSelected);

}
