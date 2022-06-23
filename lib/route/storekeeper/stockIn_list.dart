import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';

class StockInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("New Check In"),
          centerTitle: true),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 12, bottom: 50),
        itemBuilder: (ctx, index) => _Tile("RM10,000.00"),
        itemCount: 2,
        separatorBuilder: (ctx, index) => Divider(),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String price;

  _Tile(this.price);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("RFQ00045", style: TextStyle(fontWeight: FontWeight.bold)),
        onTap: () =>
            Navigator.pushNamed(context, routeCheckInInfo, arguments: true),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text(value: "Mohd Syafiq", top: 8.0),
          text(value: "2 / 5 / 2020"),
          text(value: "PR000312"),
        ]),
        trailing: state);
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

  Widget get state {
    return Container(
      height: 40,
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorTheme3,
      ),
      child: Center(
        child: Text(
          price,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
