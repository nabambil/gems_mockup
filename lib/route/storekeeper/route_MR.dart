import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';

class MaterialRequest extends StatefulWidget {
  final String status;

  MaterialRequest({@required this.status});

  @override
  _MaterialRequestState createState() => _MaterialRequestState();
}

class _MaterialRequestState extends State<MaterialRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Material Requisition Form"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _Info(),
            Divider(color: Colors.black38),
            _Title(),
            _ListView(),
          ],
        ),
      ),
      floatingActionButton: (widget.status == 'Request' ||widget.status == 'Requested') ? null : _FloatingButton(widget.status),
    );
  }
}

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
          row("MR No : ", "MR0014"),
          row("Request Date : ", "02 Mac 2020"),
          row("Request By : ", "Muhammad Zaid"),
          row("WO No : ", "WO0014"),
          row("Priority : ", "High"),
          row("Locaiton : ", "BNM"),
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

class _Title extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () => onPressed(context),
      title: Text(
        "Material",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      // trailing: Icon(Icons.add, color: Colors.grey),
    );
  }

  // void onPressed(BuildContext context) =>
  //     Navigator.pushNamed(context, routeTechnicianDetail).then(
  //       (value) => value != null ? bloc.setSink(value) : null,
  //     );
}

class _FloatingButton extends StatelessWidget {

  final String status;

  _FloatingButton(this.status);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(title),
      backgroundColor: colorTheme1,
      onPressed: () => Navigator.pop(context),
    );
  }

  String get title {
    switch (status){
    case 'Available' :
      return 'Reserved';
    case 'Unavailable' :
      return 'Add to Request';
    case 'Reserved' :
      return 'Checkout';
    default:
      return 'Submit';
    }
  }
}

class _ListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(10, (index) => _Material(index+1))
    );
  }
}

class _Material extends StatelessWidget {
  final int index;

  _Material(this.index);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          index.toString() + '.  Material $index' ,
          overflow: TextOverflow.fade,
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "Group A  |  SubGroup A", top: 8.0),
        text(value: "Quantity : 10"),
      ]),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
            child: Text('no description'),
          ),
        ),
      ],
    );
  }

  Widget text({@required String value, double top = 3.0}) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(
        value,
        style: TextStyle(color: colorTheme3),
      ),
    );
  }
}