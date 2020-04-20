import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/constant.dart';

class MyPurchaseOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _ReviewsOrders(),
          Divider(color: Colors.black38),
          _PurchasedOrders(),
        ],
      ),
    );
  }
}

class _ReviewsOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      children: <Widget>[
        Card(
            elevation: 6,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.5),
                },
                children: <TableRow>[
                  row("NEW REQUEST : ", "4"),
                  row("DONE REQUEST : ", "17"),
                  row("TOTAL REQUEST : ", "21"),
                ],
              ),
            )),
        SizedBox(height: 12),
        Card(
            elevation: 6,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.5),
                },
                children: <TableRow>[
                  row("STORE A : ", "6"),
                  row("STORE B : ", "7"),
                  row("STORE C : ", "8"),
                ],
              ),
            )),
        SizedBox(height: 12),
        Card(
            elevation: 6,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.5),
                },
                children: <TableRow>[
                  row("CRITICAL : ", "5"),
                  row("NORMAL : ", "8"),
                  row("NON WO : ", "3"),
                ],
              ),
            )),
      ],
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

class _PurchasedOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx, index) => Divider(color: Colors.black38),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 17,
      itemBuilder: (ctx, index) => _Tile(),
    );
  }
}

class _Tile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("PO00045", style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "PR00031", top: 8.0),
        text(value: "2 / 2 / 2020"),
        text(value: "Mohd Ramli bin Saripudin"),
      ]),
      trailing: state,
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
          "RM 100,000.00",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
