import 'package:tickets_repository/tickets_repository.dart';

enum TicketViewFilter {all, activeOnly, selectedOnly}

extension TicketViewFilterX on TicketViewFilter {
  bool apply(Ticket ticket) {
    switch(this) {
      case TicketViewFilter.all:
        return true;
      case TicketViewFilter.activeOnly:
        return false;
      case TicketViewFilter.selectedOnly:
        return false;
    }
  }

  Iterable<Ticket> applyAll(Iterable<Ticket> tickets) {
    return tickets.where(apply);
  }
}