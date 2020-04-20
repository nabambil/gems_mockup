import 'package:mockup_gems/utils/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

const List<String> statuses = [
  'All Status',
  'Critical',
  'Normal',
];

class BlocProcurement extends Bloc{
  final _selectedFilter = BehaviorSubject<String>.seeded(statuses.first);

  Function get setSelected => _selectedFilter.sink.add;
  Stream get selected$ => _selectedFilter.stream;

  @override
  void dispose() {
    _selectedFilter.close();
  }
}