import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:photo_view/photo_view.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Info(isCheckout: widget.status == "checkout"),
            Divider(color: Colors.black38),
            _Title(),
            _ListView(isUnavailable: widget.status == "Unavailable"),
          ],
        ),
      ),
      floatingActionButton: (widget.status == 'Request' ||
              widget.status == 'Requested' ||
              widget.status == 'Unavailable' ||
              widget.status == 'checkin')
          ? null
          : _FloatingButton(widget.status),
    );
  }
}

class _Info extends StatelessWidget {
  final bool isCheckout;

  _Info({this.isCheckout = false});

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
          row("Approved By : ", "Khairul Syafiq"),
          row("WO No : ", "WO0014"),
          row("Priority : ", "High"),
          row("Location : ", "BNM"),
          if (isCheckout) row("Checkout By : ", "Muhammad Zaid"),
          if (isCheckout) row("Checkout Date : ", "3 Mac 2020"),
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
    switch (status) {
      case 'Available':
        return 'Reserved';
      case 'Unavailable':
        return 'Add to Request';
      case 'Reserved':
        return 'Checkout';
      default:
        return 'Submit';
    }
  }
}

class _ListView extends StatelessWidget {
  final bool isUnavailable;

  const _ListView({Key key, this.isUnavailable = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 20),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: List.generate(
        10,
        (index) => _Material(
          index + 1,
          isUnavailable: index == 3 || index == 5 ? isUnavailable : false,
        ),
      ),
    );
  }
}

class _Material extends StatelessWidget {
  final bool isUnavailable;

  final int index;

  _Material(this.index, {this.isUnavailable = false});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          index.toString() + '.  Material $index',
          overflow: TextOverflow.fade,
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "Category A  |  Type A", top: 8.0),
        text(value: "Quantity : 10", color: isUnavailable ? colorTheme4 : null),
      ]),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
            child: Text('no description'),
          ),
        ),
        // TextButton(
        //     onPressed: () {
        //       Toast.show("Item added to Request", context);
        //     },
        //     child: Text("Add To Request")),
      ],
    );
  }

  Widget text({@required String value, double top = 3.0, Color color}) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(
        value,
        style: TextStyle(color: color == null ? colorTheme3 : color),
      ),
    );
  }
}
