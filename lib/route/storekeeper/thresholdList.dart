import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:toast/toast.dart';

class ThresholdListView extends StatefulWidget {
  @override
  _ThresholdListViewState createState() => _ThresholdListViewState();
}

class _ThresholdListViewState extends State<ThresholdListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(bottom: 20),
        scrollDirection: Axis.vertical,
        children: List.generate(10, (index) => _Material(index + 1)));
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
          index.toString() + '.  Material $index',
          overflow: TextOverflow.fade,
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "Group A  |  SubGroup A", top: 8.0),
        text(value: "Quantity : 10", color: colorTheme4),
      ]),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
            child: Text('no description'),
          ),
        ),
        TextButton(
            onPressed: () {
              Toast.show("Item added to Request", context);
            },
            child: Text("Add To Request")),
      ],
    );
  }

  Widget text({@required String value, double top = 3.0, Color color}) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(
        value,
        style: TextStyle(color: color ?? colorTheme3),
      ),
    );
  }
}
