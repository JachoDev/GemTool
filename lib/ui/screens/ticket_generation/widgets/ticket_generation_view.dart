import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class TicketGenerationView extends StatelessWidget {
  const TicketGenerationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((TicketGenerationBloc bloc) => bloc.state.status);
    return MultiBlocListener(
      listeners: [
        BlocListener<TicketGenerationBloc, TicketGenerationState>(
          listenWhen: (previous, current)
              => previous.status != current.status
              && current.status == TicketGenerationStatus.loading,
          listener: (context, state) {
            context.read<TicketGenerationBloc>().add(
              const TicketGenerationSendPrompt(),
            );
          }
        ),
        BlocListener<TicketGenerationBloc, TicketGenerationState>(
          listenWhen: (previous, current)
              => previous.status != current.status
              && current.status == TicketGenerationStatus.success,
          listener: (context, state) {
            context.read<TicketGenerationBloc>().add(
              const TicketGenerationVerifyTicket(),
            );
          },
        ),
        BlocListener<TicketGenerationBloc, TicketGenerationState>(
          listenWhen: (previous, current)
              => previous.isATicket != current.isATicket
              && current.isATicket,
          listener: (context, state) {
            final stringBytes = String.fromCharCodes(state.bytes!);
            final ticket = state.generatedTicket!.copyWith(imageBytes: stringBytes);
            context.go('/edit', extra: ticket);

          },
        ),
      ],

      child: Center(
        child: status.isLoading ?
        const CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.lightBlue,
          semanticsLabel: 'Progress Indicator',
          semanticsValue: '10%',
          strokeWidth: 150,
          strokeCap: StrokeCap.round,
          strokeAlign: .772,
        ) : status.isSucces ? const Icon(Icons.check_rounded, size: 300, color: Colors.green,) : const Icon(Icons.error_rounded, size: 300, color: Colors.red,),
      ),
    );
  }
}
