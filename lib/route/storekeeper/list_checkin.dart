import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';

class CheckInList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 12, bottom: 50),
      itemBuilder: (ctx, index) => _Tile("RM100,000.00"),
      itemCount: 10,
      separatorBuilder: (ctx, index) => Divider(),
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
            Navigator.pushNamed(context, routeCheckInInfo, arguments: false),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text(value: "Mohd Syafiq", top: 8.0),
          text(value: "2 / 2 / 2020"),
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
