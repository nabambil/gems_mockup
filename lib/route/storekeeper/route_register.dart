import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_technician.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterItem extends StatelessWidget {
  final BlocTechnicianDetails _bloc;

  RegisterItem() : this._bloc = BlocTechnicianDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Item"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            _Dropdown(_bloc.groups, _bloc.setGroup, _bloc.group, "Group"),
            SizedBox(height: 8),
            _Dropdown(_bloc.subs, _bloc.setSubGroup, _bloc.sub, "Sub Group"),
            SizedBox(height: 8),
            _Dropdown(_bloc.items, _bloc.setItem, _bloc.item, "Item"),
            SizedBox(height: 8),
            _Quantity(),
          ])),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: Text("Submit"),
        heroTag: "Submit",
      ),
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
              hint: selectedValue == null
                  ? "Please select one $label"
                  : selectedValue,
              onChanged: (value) => value == null ? null : dispatch(value),
              isExpanded: true,
              searchFn: (String keyword, items) {
                List<int> ret = List<int>();
                if (keyword != null && items != null && keyword.isNotEmpty) {
                  dispatch(keyword);
                  keyword.split(" ").forEach((k) {
                    int i = 0;
                    items.forEach((item) {
                      if (k.isNotEmpty &&
                          (item.value
                              .toString()
                              .toLowerCase()
                              .contains(k.toLowerCase()))) {
                        ret.add(i);
                      }
                      i++;
                    });
                  });
                }
                if (keyword.isEmpty) {
                  ret = Iterable<int>.generate(items.length).toList();
                }
                return (ret);
              });
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
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Threshold'),
      keyboardType: TextInputType.number,
    );
  }
}
