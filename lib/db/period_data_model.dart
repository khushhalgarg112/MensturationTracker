import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'period_data_model.g.dart';

//*********** PeriodData: model for saving period data ***********
@HiveType(typeId: 1)
class PeriodData extends HiveObject {

  @HiveField(0)
  late DateTime periodDate;
  
  @HiveField(1)
  late List<bool> symptoms;

  @HiveField(2)
  late String note;

  @HiveField(3, defaultValue: 0)
  late int flow;

  PeriodData(this.periodDate, this.symptoms, this.note, this.flow);
}