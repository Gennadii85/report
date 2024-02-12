import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf_invoice_generator_flutter/core/variables_con_for_mid_aft.dart';

import '../../widgets/message_save.dart';

part 'title1_state.dart';

class Title1Cubit extends Cubit<Title1State> {
  Title1Cubit()
      : super(
          Title1State(
            title: VarForMidAft().initDynamicHeader1 ??
                VarForMidAft.dynamicHeader1,
            description:
                VarForMidAft().initDescription ?? VarForMidAft.description,
          ),
        );

  dynamic contentRename(String header1, String description) {
    emit(
      Title1State(
        title: header1,
        description: description,
      ),
    );
  }

  void saveCondition(String boxName, context) async {
    // boxName = 'Condition'
    var box = await Hive.openBox(boxName);
    box.put('title', state.title);
    box.put('description', state.description);
    // box.close();
    Massage().saveMassage(context);
  }
}
