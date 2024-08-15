import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';
import 'package:gemtool/data/data.dart';

class TicketOverviewFilterButton extends StatelessWidget {
  const TicketOverviewFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((TicketOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TicketViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: 'Filter',
      onSelected: (filter) {
        context
            .read<TicketOverviewBloc>()
            .add(TicketOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: TicketViewFilter.all,
            child: Text('Show all'),
          ),
          PopupMenuItem(
            value: TicketViewFilter.unselectedOnly,
            child: Text('show unselected'),
          ),
          PopupMenuItem(
            value: TicketViewFilter.selectedOnly,
            child: Text('Show selected'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
