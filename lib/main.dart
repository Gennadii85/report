import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/data/model/holds_model.dart';
import 'package:pdf_invoice_generator_flutter/presentation/pages/home_page.dart';
import 'presentation/cubit/add_new_table_row/add_new_table_row_cubit.dart';
import 'presentation/cubit/aft_section/aft_table_cubit.dart';
import 'presentation/cubit/condition_section/title1_cubit.dart';
import 'presentation/cubit/description_acc_eng_car/description_acc_eng_car_cubit.dart';
import 'presentation/cubit/forward_section/forward_table_cubit.dart';
import 'presentation/cubit/middle_section/middle_table_cubit.dart';
import 'presentation/cubit/one_hold/forward_section/one_hold_forward_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HoldModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Title1Cubit(),
        ),
        BlocProvider(
          create: (context) => TableCubitForward(),
        ),
        BlocProvider(
          create: (context) => TableCubitMiddle(),
        ),
        BlocProvider(
          create: (context) => TableCubitAft(),
        ),
        BlocProvider(
          create: (context) => AddNewTableRowCubit(),
        ),
        BlocProvider(
          create: (context) => DescriptionAccEngCarCubit(),
        ),
        // BlocProvider(
        //   create: (context) => OneHoldForwardCubit(indexHold),
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
