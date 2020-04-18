import 'package:flutter/foundation.dart';
import 'package:mockup_gems/utils/bloc/bloc.dart';
import 'package:rxdart/subjects.dart';

const List<String> statuses = [
  'All Status',
  'Available',
  'Unavailable',
  'Request',
  'Requested',
  'Reserved',
];

class BlocInventory extends Bloc {
  final _selectedFilter = BehaviorSubject<String>.seeded(statuses.first);
  final _requestCart = BehaviorSubject<Material>();
  final _myView = BehaviorSubject<String>.seeded("My Stock");
  final _myStock = BehaviorSubject<List<Stock>>();

  Stream get selected$ => _selectedFilter.stream;
  Stream get material$ => _requestCart.stream;
  Stream get view$ => _myView.stream;
  Stream get stock$ => _myStock.stream;

  Function get setSelected => _selectedFilter.sink.add;
  Function get setMaterial => _selectedFilter.sink.add;
  Function get setView => _myView.sink.add;

  BlocInventory(){
    _myStock.add(['A','B','C'].map((f) => Stock(group: "Group $f")).toList());
  }

  @override
  void dispose() {
    _selectedFilter.close();
    _requestCart.close();
    _myView.close();
    _myStock.close();
  }
}

enum RequestStatus {
  Processing,
  Requested,
  Reserved,
}

class Material extends Bloc{
  final _controllerThreshold = BehaviorSubject<int>.seeded(10);
  final String issuedBy;
  final String group;
  final String subgroup;
  final String name;
  final String desc;
  double price;
  int quantity;

  void get addThreshold => _controllerThreshold.sink.add(_controllerThreshold.value + 1);
  void get minusThreshold => _controllerThreshold.sink.add(_controllerThreshold.value - 1);

  Material({
    @required this.issuedBy,
    @required this.group,
    @required this.subgroup,
    @required this.name,
    @required this.desc,
    @required this.quantity,
    this.price,
  });

  void addQuantity() {
    quantity += 1;
  }

  void minusQuantity() {
    if (quantity > 0) quantity -= 1;
  }

  Stream<int> get threshold  => _controllerThreshold.stream;

  @override
  void dispose() {
    _controllerThreshold.close();
  }
}

class Stock {
  final String group;
  final List<Group> subgroups;

  Stock({@required this.group, subgroups})
      : this.subgroups = subgroups ??
            ['A', 'B', 'C']
                .map((f) => Group(subgroup: "Sub Group $f", group: group))
                .toList();
  
  String get quantity => subgroups.length.toString();

}

class Group {
  final String subgroup;
  final List<Material> materials;

  Group({@required this.subgroup, @required group, materials})
      : this.materials = materials ??
            ['A', 'B', 'C']
                .map((f) => Material(
                      issuedBy: "Muhammad Nabil",
                      group: group,
                      subgroup: subgroup,
                      name: "Item $f",
                      desc: null,
                      quantity: 10,
                    ))
                .toList();

  String get quantity => materials.length.toString();
}
