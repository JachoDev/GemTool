import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_api/ticket_api.dart';
/// {@template local_storage_ticket_api}
/// A Flutter implementation of the TicketApi that uses local storage.
/// {@endtemplate}
class LocalStorageTicketApi extends TicketApi{
  /// {@macro local_storage_ticket_api}
  LocalStorageTicketApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  late final _ticketStreamController = BehaviorSubject<List<Ticket>>.seeded(
    const [],
  );

  @visibleForTesting
  static const kTicketCollectionKey = '__ticket_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final ticketJson = _getValue(kTicketCollectionKey);
    if (ticketJson != null) {
      final tickets = List<Map<dynamic, dynamic>>.from(
        json.decode(ticketJson) as List,
      )
          .map((jsonMap) => Ticket.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _ticketStreamController.add(tickets);
    } else {
      _ticketStreamController.add(const []);
    }
  }

  @override
  Stream<List<Ticket>> getTickets() => _ticketStreamController.asBroadcastStream();

  @override
  Future<void> saveTicket(Ticket ticket) {
    final tickets = [..._ticketStreamController.value];
    final ticketIndex = tickets.indexWhere((t) => t.id == ticket.id);
    if (ticketIndex >= 0) {
      tickets[ticketIndex] = ticket;
    } else {
      tickets.add(ticket);
    }

    _ticketStreamController.add(tickets);
    return _setValue(kTicketCollectionKey, json.encode(tickets));
  }

  @override
  Future<void> deleteTicket(String id) async {
    final tickets = [..._ticketStreamController.value];
    final ticketIndex = tickets.indexWhere((t) => t.id == id);
    if (ticketIndex == -1) {
      throw TicketNotFoundException();
    } else {
      tickets.removeAt(ticketIndex);
      _ticketStreamController.add(tickets);
      return _setValue(kTicketCollectionKey, json.encode(tickets));
    }
  }

  @override
  Future<void> close() {
    return _ticketStreamController.close();
  }

  @override
  Future<int> deleteAll() async {
    final tickets = [..._ticketStreamController.value];
    final deletedTicketsAmount = tickets.length;
    tickets.clear();
    _ticketStreamController.add(tickets);
    await _setValue(kTicketCollectionKey, json.encode(tickets));
    return deletedTicketsAmount;
  }

  @override
  Future<int> clearSelected() async {
    final tickets = [..._ticketStreamController.value];
    final selectedTicketsAmount = tickets.where((t) => t.isSelected).length;
    tickets.removeWhere((t) => t.isSelected);
    _ticketStreamController.add(tickets);
    await _setValue(kTicketCollectionKey, json.encode(tickets));
    return selectedTicketsAmount;
  }

  @override
  Future<int> selectAll({required bool isSelected}) async {
    final tickets = [..._ticketStreamController.value];
    final changedTicketsAmount =
        tickets.where((t) => t.isSelected != isSelected).length;
    final newTickets = [
      for (final ticket in tickets) ticket.copyWith(isSelected: isSelected),
    ];
    _ticketStreamController.add(newTickets);
    await _setValue(kTicketCollectionKey, json.encode(newTickets));
    return changedTicketsAmount;
  }

}
