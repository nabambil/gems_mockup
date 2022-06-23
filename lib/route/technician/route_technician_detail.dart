import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_technician.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:toast/toast.dart';

class RouteTechnicianDetail extends StatefulWidget {
  final Item item;

  RouteTechnicianDetail({this.item});

  @override
  _RouteTechnicianDetailState createState() =>
      _RouteTechnicianDetailState(item);
}

class _RouteTechnicianDetailState extends State<RouteTechnicianDetail> {
  BlocTechnicianDetails _bloc = BlocTechnicianDetails();

  _RouteTechnicianDetailState(item) {
    if (item != null) {
      _bloc.setItem(item.name);
      _bloc.setGroup(item.group);
      _bloc.setSubGroup(item.subgroup);
      _bloc.setDesc(item.desc);
      _bloc.setQuantity(item.quantity.toString());
    }

    _bloc.loadingState.listen((value) {
      if (value == true)
        showDialog(
          context: context,
          builder: (_) => Center(child: CircularProgressIndicator()),
        );
      else
        Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Material Information"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            _Dropdown(_bloc.groups, _bloc.setGroup, _bloc.group, "Group"),
            SizedBox(height: 8),
            _Dropdown(_bloc.subs, _bloc.setSubGroup, _bloc.sub, "Sub Group"),
            SizedBox(height: 8),
            _Dropdown(_bloc.items, _bloc.setItem, _bloc.item, "Item"),
            _Quantity(_bloc),
            _Description(_bloc),
          ]),
        ),
      ),
      floatingActionButton: _FloatingButton(_bloc),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final Stream<List<String>> subscribe;
  final Function dispatch;
  final Stream<String> listen;
  final String label;

  _Dropdown(this.subscribe, this.dispatch, this.listen, this.label);

  @override
  Widget build(BuildContext context) {
    return streaming<List<String>>(
      subscribe,
      (listValue) => streaming<String>(
        listen,
        (selectedValue) {
          if (listValue == null && label != "Group")
            return TextField(
              decoration: InputDecoration(
                  labelText: label, suffixIcon: Icon(Icons.arrow_drop_down)),
              enabled: false,
            );

          return SearchableDropdown.single(
            items: (listValue ?? ["select one"])
                .map<DropdownMenuItem<String>>((f) => DropdownMenuItem(
                      child: Text(f),
                      value: f,
                    ))
                .toList(),
            value: selectedValue,
            label: label,
            hint: "Please select one $label",
            onChanged: dispatch,
            isExpanded: true,
          );
        },
      ),
    );
  }

  StreamBuilder streaming<T>(Stream<T> subscribe, Widget Function(T) builder) {
    return new StreamBuilder<T>(
      stream: subscribe,
      builder: (ctx, snapshot) {
        // if (T is String)
        //   return builder(snapshot.data);
        if (snapshot.data == null && snapshot.error != null)
          return TextField(
            decoration: InputDecoration(
                labelText: label, suffixIcon: Icon(Icons.arrow_drop_down)),
            enabled: false,
          );

        return builder(snapshot.data);
      },
    );
  }
}

class _Quantity extends StatelessWidget {
  final BlocTechnicianDetails bloc;

  _Quantity(this.bloc);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: bloc.quantity != null
            ? TextEditingController(text: bloc.quantity.toString())
            : null,
        decoration: InputDecoration(labelText: 'Quantity'),
        keyboardType: TextInputType.number,
        onChanged: bloc.setQuantity);
  }
}

class _Description extends StatelessWidget {
  final BlocTechnicianDetails bloc;

  _Description(this.bloc);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller:
            bloc.desc != null ? TextEditingController(text: bloc.desc) : null,
        decoration: InputDecoration(labelText: 'Description'),
        keyboardType: TextInputType.multiline,
        maxLength: 100,
        maxLines: null,
        onChanged: bloc.setDesc);
  }
}

class _FloatingButton extends StatelessWidget {
  final BlocTechnicianDetails bloc;

  _FloatingButton(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.verifySubmittion,
        builder: (context, snapshot) => FloatingActionButton.extended(
              heroTag: "submit",
              label: Text("Submit"),
              backgroundColor: colorTheme3,
              onPressed: () => snapshot.data == null
                  ? Toast.show("Please fill all dropdown", context, duration: 3)
                  : snapshot.data == false
                      ? Toast.show("Please fill all dropdown", context,
                          duration: 3)
                      : Navigator.pop(context, bloc.itemValue),
            ));
  }
}
