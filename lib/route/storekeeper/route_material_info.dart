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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: threshold(material),
                ),
              ]);
        },
        itemCount: value.materials.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }

  Widget threshold(bloc.Material value) => StreamBuilder(
        stream: value.threshold,
        builder: (ctx, snapshot) => Row(
          children: <Widget>[
            Text("Set Threshold : ", style: TextStyle(color: colorTheme4),),
            IconButton(
                icon: Icon(Icons.remove, color: Colors.grey),
                onPressed: () => snapshot.data != 0  ? value.minusThreshold : null),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 20, color: colorTheme4),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add, color: Colors.grey),
                onPressed: () => value.addThreshold),
          ],
        ),
      );

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
          SizedBox(height:6),
          Text(material.desc ?? "No description"),
        ],
      ),
    );
  }  
}
