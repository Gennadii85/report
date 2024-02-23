import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_invoice_generator_flutter/core/have_variables.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';
import '../cubit/condition_section/title1_cubit.dart';
import '../widgets/all_section/app_bar_save_button.dart';
import '../widgets/all_section/description.dart';
import '../widgets/all_section/drawer_navigation.dart';
import '../widgets/all_section/title_text.dart';

class Condition extends StatefulWidget {
  const Condition({super.key, required this.titleAppBar});
  final String titleAppBar;

  @override
  State<Condition> createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.titleAppBar),
          actions: [
            AppBarSaveButton(
              function: (context) => BlocProvider.of<Title1Cubit>(context)
                  .saveCondition(VarHave.boxCondition, context),
            ),
          ],
        ),
        drawer: const DrawerNavigation(),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                DescriptionBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptionBoard extends StatelessWidget {
  const DescriptionBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Title1Cubit, Title1State>(
      builder: (context, state) {
        return Column(
          children: [
            Description(
              title: state.title,
              function: (controllerText) {
                BlocProvider.of<Title1Cubit>(context)
                    .contentRename(controllerText, state.description);
              },
            ),
            const SizedBox(height: 10),
            const TitleText(
              title: VarForMidAft.header2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const TitleText(
              title: VarForMidAft.header3,
              textAlign: TextAlign.start,
            ),
            Description(
              title: state.description,
              function: (controllerText) =>
                  BlocProvider.of<Title1Cubit>(context)
                      .contentRename(state.title, controllerText),
            ),
          ],
        );
      },
    );
  }
}
