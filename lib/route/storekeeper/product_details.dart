import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_material.dart';
import 'package:mockup_gems/utils/constant.dart';

class MaterialDetails extends StatefulWidget {
  @override
  _MaterialDetailsState createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  final BlocMaterial _bloc = BlocMaterial();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _Info(),
              Divider(thickness: 0.5, color: Colors.black38),
              threshold(_bloc),
              setMinimum(_bloc),
              setMaximum(_bloc),
            ],
          ),
        ),
      ),
    );
  }
}

Widget threshold(BlocMaterial value) => StreamBuilder<int>(
      stream: value.threshold,
      builder: (ctx, snapshot) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Text(
              "Set Threshold : ",
              style: TextStyle(color: colorTheme4),
            ),
            IconButton(
                icon: Icon(Icons.remove, color: Colors.grey),
                onPressed: () =>
                    snapshot.data != 0 ? value.minusThreshold() : null),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 20, color: colorTheme4),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add, color: Colors.grey),
                onPressed: () => value.addThreshold()),
          ],
        ),
      ),
    );

Widget setMinimum(BlocMaterial value) => StreamBuilder<int>(
      stream: value.minOrder,
      builder: (ctx, snapshot) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Text(
              "Set Min Order : ",
              style: TextStyle(color: colorTheme3),
            ),
            IconButton(
                icon: Icon(Icons.remove, color: Colors.grey),
                onPressed: () => snapshot.data != 0 ? value.minusMin() : null),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 20, color: colorTheme3),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add, color: Colors.grey),
                onPressed: () => value.addMin()),
          ],
        ),
      ),
    );

Widget setMaximum(BlocMaterial value) => StreamBuilder<int>(
      stream: value.maxOrder,
      builder: (ctx, snapshot) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Text(
              "Set Max Order : ",
              style: TextStyle(color: colorTheme3),
            ),
            IconButton(
                icon: Icon(Icons.remove, color: Colors.grey),
                onPressed: () => snapshot.data != 0 ? value.minusMax() : null),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 20, color: colorTheme3),
              ),
            ),
            IconButton(
                icon: Icon(Icons.add, color: Colors.grey),
                onPressed: () => value.addMax()),
          ],
        ),
      ),
    );

class _Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(.30),
        },
        children: <TableRow>[
          row("Serial No : ", "BRFG023953G"),
          row("Category : ", "A"),
          row("Type : ", "B"),
          row("Last Update By : ", "Muhammad Nabil"),
          row("Date Update : ", "02 Mac 2020"),
          row("Quantity : ", "10"),
          row("Price per Unit (RM) : ", "2.20"),
          row("Description : ", "Item A"),
        ],
      ),
    );
  }

  TableRow row(String title, String value) {
    return TableRow(children: [
      TableCell(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
      TableCell(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(value),
      )),
    ]);
  }
}
