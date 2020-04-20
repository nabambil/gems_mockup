import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_procurement.dart';
import 'package:mockup_gems/utils/constant.dart';

class PurchaseOrderList extends StatelessWidget {
  final BlocProcurement bloc;

  PurchaseOrderList(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(stream : bloc.selected$, builder:(ctx,snapshot) => ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      itemBuilder: (ctx, index) => _Tile(snapshot.data != "All Status" ? snapshot.data : statuses[index+1], index),
      itemCount: snapshot.data != "All Status" ? 1: statuses.length - 1 ,
      separatorBuilder: (ctx, index) => Divider(),
    ),);
  }
}

class _Tile extends StatelessWidget {
  final String status;
  final int index;

  _Tile(this.status, this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("PR00123", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text(value: "Sharif Ishak", top: 8.0),
          text(value: "2 / 2 / 2020"),
          text(value: "Store A"),
        ]),
        trailing: state, onTap: (){
          // Navigator.pushNamed(context, routeMateralRequest, arguments: status);
        },);
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
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colors,
      ),
      child: Center(
        child: Text(
          status ?? "Loading",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Color get colors => [colorTheme4, colorTheme1][index];
}
