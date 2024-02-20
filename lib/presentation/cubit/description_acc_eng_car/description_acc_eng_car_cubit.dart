import 'package:bloc/bloc.dart';

part 'description_acc_eng_car_state.dart';

class DescriptionAccEngCarCubit extends Cubit<DescriptionAccEngCarState> {
  DescriptionAccEngCarCubit() : super(DescriptionAccEngCarState(date: []));
}
