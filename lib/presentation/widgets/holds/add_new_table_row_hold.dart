import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/one_hold/aft_section/aft_section_cubit.dart';
import '../../cubit/one_hold/forward_section/forward_section_cubit.dart';
import '../../cubit/one_hold/port_section/port_section_cubit.dart';
import '../../cubit/one_hold/starboard_section/starboard_section_cubit.dart';
import '../../cubit/one_hold/tank_section/tank_section_cubit.dart';
import 'abb_new_table_row_hold_body.dart';

class AddNewTableRowForwardHold extends StatelessWidget {
  final MaterialPageRoute route;
  const AddNewTableRowForwardHold({super.key, required this.route});

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    OneHoldForwardCubit cubit = BlocProvider.of<OneHoldForwardCubit>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddNewTableRowDescription(),
              const SizedBox(height: 50),
              BlocBuilder<OneHoldForwardCubit, OneHoldForwardState>(
                builder: (context, state) {
                  return AddNewTableRowHoldBody(
                    route: route,
                    updateList: cubit.updateList,
                    updateValue: cubit.updateValue,
                    updateEditValue: cubit.updateEditValue,
                    saveTableRow: cubit.saveTableRow,
                    resetState: cubit.resetState,
                    name: state.name,
                    value: state.value,
                    valueList: state.valueList,
                    editValue: state.editValue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTableRowStarboardHold extends StatelessWidget {
  final MaterialPageRoute route;
  const AddNewTableRowStarboardHold({super.key, required this.route});

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    OneHoldStarboardCubit cubit =
        BlocProvider.of<OneHoldStarboardCubit>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddNewTableRowDescription(),
              const SizedBox(height: 50),
              BlocBuilder<OneHoldStarboardCubit, OneHoldStarboardState>(
                builder: (context, state) {
                  return AddNewTableRowHoldBody(
                    route: route,
                    updateList: cubit.updateList,
                    updateValue: cubit.updateValue,
                    updateEditValue: cubit.updateEditValue,
                    saveTableRow: cubit.saveTableRow,
                    resetState: cubit.resetState,
                    name: state.name,
                    value: state.value,
                    valueList: state.valueList,
                    editValue: state.editValue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTableRowAftHold extends StatelessWidget {
  final MaterialPageRoute route;
  const AddNewTableRowAftHold({super.key, required this.route});

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    OneHoldAftCubit cubit = BlocProvider.of<OneHoldAftCubit>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddNewTableRowDescription(),
              const SizedBox(height: 50),
              BlocBuilder<OneHoldAftCubit, OneHoldAftState>(
                builder: (context, state) {
                  return AddNewTableRowHoldBody(
                    route: route,
                    updateList: cubit.updateList,
                    updateValue: cubit.updateValue,
                    updateEditValue: cubit.updateEditValue,
                    saveTableRow: cubit.saveTableRow,
                    resetState: cubit.resetState,
                    name: state.name,
                    value: state.value,
                    valueList: state.valueList,
                    editValue: state.editValue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTableRowPortHold extends StatelessWidget {
  final MaterialPageRoute route;
  const AddNewTableRowPortHold({super.key, required this.route});

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    OneHoldPortCubit cubit = BlocProvider.of<OneHoldPortCubit>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddNewTableRowDescription(),
              const SizedBox(height: 50),
              BlocBuilder<OneHoldPortCubit, OneHoldPortState>(
                builder: (context, state) {
                  return AddNewTableRowHoldBody(
                    route: route,
                    updateList: cubit.updateList,
                    updateValue: cubit.updateValue,
                    updateEditValue: cubit.updateEditValue,
                    saveTableRow: cubit.saveTableRow,
                    resetState: cubit.resetState,
                    name: state.name,
                    value: state.value,
                    valueList: state.valueList,
                    editValue: state.editValue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTableRowTankHold extends StatelessWidget {
  final MaterialPageRoute route;
  const AddNewTableRowTankHold({super.key, required this.route});

  void goRoute(context) => Navigator.of(context).push(route);

  @override
  Widget build(BuildContext context) {
    OneHoldTankCubit cubit = BlocProvider.of<OneHoldTankCubit>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Добавляем таблицу'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddNewTableRowDescription(),
              const SizedBox(height: 50),
              BlocBuilder<OneHoldTankCubit, OneHoldTankState>(
                builder: (context, state) {
                  return AddNewTableRowHoldBody(
                    route: route,
                    updateList: cubit.updateList,
                    updateValue: cubit.updateValue,
                    updateEditValue: cubit.updateEditValue,
                    saveTableRow: cubit.saveTableRow,
                    resetState: cubit.resetState,
                    name: state.name,
                    value: state.value,
                    valueList: state.valueList,
                    editValue: state.editValue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewTableRowDescription extends StatelessWidget {
  const AddNewTableRowDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Выберите нужные параметры и сохраните их !'),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Если нужно редактировать строку просто создайте ее заново и выберите нужное значение!',
          ),
        ),
      ],
    );
  }
}
