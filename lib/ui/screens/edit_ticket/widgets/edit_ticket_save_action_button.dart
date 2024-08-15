import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

class EditTicketSaveActionButton extends StatelessWidget {
  const EditTicketSaveActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final status =
    context.select((EditTicketBloc bloc) => bloc.state.status);

    return FloatingActionButton(
      tooltip: 'Save',
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      onPressed: status.isLoadingOrSuccess
          ? null
          : () => context.read<EditTicketBloc>().add(
        const EditTicketSubmitted(),
      ),
      child: status.isLoadingOrSuccess
          ? const CupertinoActivityIndicator()
          : const Icon(Icons.check_rounded),
    );
  }
}
