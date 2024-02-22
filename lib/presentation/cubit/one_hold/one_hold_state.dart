// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'one_hold_cubit.dart';

class OneHoldForwardState {
  Map tableMapForward;
  List<String> listImagePathForward;
  String? name;
  String? editValue;
  List<String> valueList = [];
  String value = '';
  OneHoldForwardState({
    required this.tableMapForward,
    required this.listImagePathForward,
    required this.valueList,
    required this.value,
    this.name,
    this.editValue,
  });
}
