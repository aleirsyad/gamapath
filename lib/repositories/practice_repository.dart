import 'package:gamapath/model/PracticeModel.dart';
import 'package:gamapath/provider/practice_provider.dart';

class PracticeRepository{
  final _practiceProvider = PracticeProvider();

  Future<List<PracticeItem>> getPractice(){
    return _practiceProvider.getPractice();
  }
}

class PracticeNetworkError extends Error{}