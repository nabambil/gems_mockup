import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_inventory.dart' as bloc;
import 'package:mockup_gems/utils/constant.dart';

class MaterialInfo extends StatelessWidget {
  final bloc.Group value;

  MaterialInfo({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(this.value.subgroup), backgroundColor: Colors.white),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          bloc.Material material = value.materials[index];
          return ExpansionTile(
              title: text(material.name, material.quantity.toString()),
              children: [
                expandedView(material),
                TextButton(
                  child: Text("View Details"),
                  onPressed: () => Navigator.pushNamed(context, routeDetails),
                )
              ]);
        },
        itemCount: value.materials.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }

  Widget text(title, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title),
        Text(number),
      ],
    );
  }

  Widget expandedView(bloc.Material material) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(material.issuedBy),
          SizedBox(height: 6),
          Text(material.desc ?? "No description"),
        ],
      ),
    );
  }
}
