import 'package:tickets_repository/tickets_repository.dart';

enum TicketViewFilter {all, unselectedOnly, selectedOnly}

extension TicketViewFilterX on TicketViewFilter {
  bool apply(Ticket ticket) {
    switch(this) {
      case TicketViewFilter.all:
        return true;
      case TicketViewFilter.unselectedOnly:
        return !ticket.isSelected;
      case TicketViewFilter.selectedOnly:
        return ticket.isSelected;
    }
  }

  Iterable<Ticket> applyAll(Iterable<Ticket> tickets) {
    return tickets.where(apply);
  }
}