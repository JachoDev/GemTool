import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gemtool/bloc/bloc.dart';

class TicketGenerationView extends StatelessWidget {
  const TicketGenerationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final state = context.select((TicketGenerationBloc bloc) => bloc.state.status);
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
            print('buenas noches');
          },
        ),
      ],

      child: const Center(child: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.lightBlue,
        semanticsLabel: 'Progress Indicator',
        semanticsValue: '10%',
        strokeWidth: 150,
        strokeCap: StrokeCap.round,
        strokeAlign: .772,
      )
        ,),
    );
  }
}
