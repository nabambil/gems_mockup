import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_inventory.dart';
import 'package:mockup_gems/utils/constant.dart';

class MyStock extends StatelessWidget {
  final BlocInventory bloc;

  MyStock(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0, bottom: 40),
      child: StreamBuilder<List<Stock>>(
        stream: bloc.stock$,
        builder: (ctx, snapshot) {
          if (snapshot.hasData)
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                List<Stock> values = snapshot.data;
                Stock value = values[index];
                return ExpansionTile(
                    title: text(value.group, value.quantity),
                    children: value.subgroups
                        .map((x) => ListTile(title: text(x.subgroup, x.quantity), trailing: Icon(Icons.navigate_next), onTap: (){
                          Navigator.pushNamed(context, routeMaterialInfo, arguments: x);
                        },))
                        .toList());
              },
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
            );
          else
            return Container(child: Center(child: Text("Loading...")));
        },
      ),
    );
  }

  Widget text(title, number,{ bool hero = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title),
        Text(number),
      ],
    );
  }
}
