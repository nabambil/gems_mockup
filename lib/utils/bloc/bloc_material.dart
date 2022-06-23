import 'package:rxdart/subjects.dart';

import 'bloc.dart';

class BlocMaterial extends Bloc {
  // VARIABLES
  final BehaviorSubject<int> _threshold = BehaviorSubject<int>.seeded(7);
  final BehaviorSubject<int> _minOrder = BehaviorSubject<int>.seeded(4);
  final BehaviorSubject<int> _maxOrder = BehaviorSubject<int>.seeded(20);

  // MEHTODS : GET
  get threshold => _threshold.stream;
  get minOrder => _minOrder.stream;
  get maxOrder => _maxOrder.stream;

  // MEHTHOS : SINK
  set threshold(int value) => _threshold.sink.add(value);
  set minOrder(int value) => _minOrder.sink.add(value);
  set maxOrder(int value) => _maxOrder.sink.add(value);

  // DISPOSE
  @override
  void dispose() {
    _threshold.close();
    _minOrder.close();
    _maxOrder.close();
  }

  // METHODS : LISTENER

  // METHODS
  void addThreshold() => threshold = (_threshold.value + 1);
  void minusThreshold() => threshold = (_threshold.value - 1);
  void addMin() => minOrder = (_minOrder.value + 1);
  void minusMin() => minOrder = (_minOrder.value - 1);
  void addMax() => maxOrder = (_maxOrder.value + 1);
  void minusMax() => maxOrder = (_maxOrder.value - 1);
}
