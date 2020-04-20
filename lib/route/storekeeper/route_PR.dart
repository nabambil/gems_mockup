import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_technician.dart';
import 'package:mockup_gems/utils/constant.dart';

class PurchaseRequest extends StatefulWidget {
  @override
  _PurchaseRequestState createState() => _PurchaseRequestState();
}

class _PurchaseRequestState extends State<PurchaseRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Purchase Requisition Form"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _TitleMaterial(),
            _ListMaterial(),
            Divider(color: Colors.black),
            _TitleTask(),
            _ListTask(),
          ],
        ),
      ),
      floatingActionButton: _FloatingButton(),
    );
  }
}

class _TitleMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onPressed(context),
      title: Text(
        "Material",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.add, color: Colors.grey),
    );
  }

  void onPressed(BuildContext context) =>
      Navigator.pushNamed(context, routeTechnicianDetail);
}

class _TitleTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          "Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('Submit'),
      backgroundColor: colorTheme1,
      onPressed: () => Navigator.pushNamed(context, routeProcurement),
    );
  }
}

class _ListMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(10, (index) => _Material(index + 1)));
  }
}

class _ListTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom:50),
      separatorBuilder: (ctx, _) => Divider(color: Colors.black38,),
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (ctx, index) => _Tile(index),
    );
  }
}

class _Material extends StatefulWidget {
  final int index;

  _Material(this.index);

  @override
  _MaterialState createState() => _MaterialState();
}

class _MaterialState extends State<_Material> {
  final minQuantity = 10;
  int quantity = 10;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          widget.index.toString() + '.  Material ${widget.index}',
          overflow: TextOverflow.fade,
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "Group A  |  SubGroup A", top: 8.0),
        text(value: "Quantity : 10"),
      ]),
      children:[
       Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.remove, color: Colors.grey),
              onPressed: () => setState((){
                if(quantity > minQuantity) quantity--;

              }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              quantity.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.grey),
            onPressed: () => setState(()=> quantity++),
          ),
        ],
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

class _Tile extends StatelessWidget {
  final int index;

  _Tile(this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        text(value: "Mohd Syafiq", top: 8.0),
        text(value: "2 / 2 / 2020"),
        text(value: "WO00045"),
      ]),
      trailing: state,
      onTap: () {
        Navigator.pushNamed(context, routeMateralRequest, arguments: 'Request');
      },
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
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorTheme4,
      ),
      child: Center(
        child: Text(
          'MR00031',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
