import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mockup_gems/utils/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

enum ScreenType {
  forTechnician,
  forEngineer,
}

class BlocTechnician extends Bloc {
  final List<Item> items;
  ScreenType type;

  final BehaviorSubject<List<Item>> _controller = BehaviorSubject<List<Item>>();
  final BehaviorSubject<String> _comment = BehaviorSubject<String>();
  Stream get stream => _controller.stream;
  Stream get comment => _comment.stream;

  BlocTechnician({this.type = ScreenType.forTechnician}) : items = List.generate(1, (index) => Item(group: "Group A", subgroup: "SubGroup A", name: "ITEM" + index.toString(), desc: "DESC A", quantity: 1)) {
    _controller.sink.add(items);
  }

  BlocTechnician.from(BlocTechnician value) : this.items = value.items, this.type = value.type{
    _controller.sink.add(items);
  }

  @override
  void dispose() {
    _controller.close();
    _comment.close();
  }

  void setSink(Item item) {
    items.add(item);

    _controller.sink.add(items);
  }

  void setComment(String value) => _comment.sink.add(value);

  void removeItem(Item item) {
    items.removeWhere((f) => f == item);

    _controller.sink.add(items);
  }

  void replaceItem(Item oldItem, Item newItem) {
    int index = items.indexWhere((item) => item == oldItem);
    items.removeWhere((f) => f == oldItem);
    items.insert(index, newItem);

    _controller.sink.add(items);
  }
}

class BlocTechnicianDetails extends Bloc {

  final BehaviorSubject<String> _controllerGroup = BehaviorSubject<String>();
  final BehaviorSubject<String> _controllerSubGroup = BehaviorSubject<String>();
  final BehaviorSubject<String> _controllerItem = BehaviorSubject<String>();
  final BehaviorSubject<List<String>> _controllerGroups = BehaviorSubject<List<String>>();
  final BehaviorSubject<List<String>> _controllerSubGroups = BehaviorSubject<List<String>>();
  final BehaviorSubject<List<String>> _controllerItems = BehaviorSubject<List<String>>();
  final BehaviorSubject<bool> _controllerLoading = BehaviorSubject<bool>();

  int _quantity;
  String _desc;
  String _name;
  String _group;
  String _subgroup;

  final List<String> listGroup = ['Group A', 'Group B', 'Group C'];
  final List<String> listSubGroup = ['SubGroup A', 'SubGroup B', 'SubGroup C'];
  final List<String> listItem = ['Item A', 'Item B', 'Item C'];

  Stream<List<String>> get groups => _controllerGroups.stream;
  Stream<List<String>> get subs   => _controllerSubGroups.stream;
  Stream<List<String>> get items  => _controllerItems.stream;
  Stream<String> get group => _controllerGroup.stream;
  Stream<String> get sub   => _controllerSubGroup.stream;
  Stream<String> get item  => _controllerItem.stream;
  Stream<bool> get loadingState => _controllerLoading.stream;

  int get quantity => _quantity;
  String get desc => _desc;

  BlocTechnicianDetails(){
    setLoading();

    Future.delayed(Duration(milliseconds: 500),(){
      _controllerGroups.sink.add(listGroup);
    }).whenComplete(setLoaded);

    group.listen((value){
      setLoading();

      Future.delayed(Duration(milliseconds: 500),(){
        _controllerSubGroups.sink.add(listSubGroup);
      }).whenComplete(setLoaded);
    });

    sub.listen((value){
      setLoading();

      Future.delayed(Duration(milliseconds: 500),(){
        _controllerItems.sink.add(listItem);
      }).whenComplete(setLoaded);
    });
  }

  void setLoading() => _controllerLoading.sink.add(true);
  void setLoaded()  => _controllerLoading.sink.add(false);
  void setItem(String value) {
    if (!_controllerItems.value.contains(value)){
      final list = listGroup;
      list.add(value);
      _controllerItems.sink.add(list);
    }

    _name = value;
    _controllerItem.sink.add(value);
  }
  void setQuantity(String value) => _quantity = int.parse(value);
  void setDesc(String value) => _desc = value;
  void setGroup(String value){
    if (!_controllerGroups.value.contains(value)){
      final list = listGroup;
      list.add(value);
      _controllerGroups.sink.add(list);
    }

    _group = value;
    _controllerGroup.sink.add(value);
  } 
  void setSubGroup(String value) { 
    if (!_controllerSubGroups.value.contains(value)){
      final list = listSubGroup;
      list.add(value);
      _controllerSubGroups.sink.add(list);
    }

    _subgroup = value;
    _controllerSubGroup.sink.add(value);
  }


  Item get itemValue => Item(group: _group, subgroup: _subgroup, name: _name, desc: _desc, quantity: _quantity ?? 0);

  Stream<bool> get verifySubmittion => CombineLatestStream.combine3(group, sub, item, (a,b,c) => true);

  @override
  void dispose() {
    _controllerLoading.close();
    _controllerGroup.close();    
    _controllerSubGroup.close();
    _controllerItem.close();    
    _controllerGroups.close();
    _controllerSubGroups.close();
    _controllerItems.close();
  }
}

class Item {
  final String group;
  final String subgroup;
  final String name;
  final String desc;
  int quantity;

  Item({@required this.group, @required this.subgroup, @required this.name, @required this.desc, @required this.quantity});
  
  void addQuantity(){
    quantity += 1;
  }

  void minusQuantity(){
    if(quantity > 0)
    quantity -= 1;
  }
}