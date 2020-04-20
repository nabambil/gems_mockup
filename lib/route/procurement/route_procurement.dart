import 'package:flutter/material.dart';
import 'package:mockup_gems/route/procurement/route_purchase_ordering.dart';
import 'package:mockup_gems/route/procurement/route_purchase_orders.dart';
import 'package:mockup_gems/utils/bloc/bloc_procurement.dart';
import 'package:mockup_gems/utils/constant.dart';

class ProcumentHomepage extends StatefulWidget {
  @override
  _ProcumentHomepageState createState() => _ProcumentHomepageState();
}

class _ProcumentHomepageState extends State<ProcumentHomepage>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(_controller),
      body: _Body(_controller),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  final TabController _controller;
  _AppBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: new Text("Purchase Ordering"),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: leading,
      actions: <Widget>[_SearchButton(), SizedBox(width: 6)],
      bottom: bottom,
    );
  }

  get leading {
    return Container(
      child: Image.asset("assets/icon_trans.png", height: 30, width: 30),
      padding: EdgeInsets.all(14),
    );
  }

  get bottom {
    return TabBar(
      labelColor: colorTheme3,
      controller: _controller,
      tabs: <Widget>[
        Tab(text: "My Purchase Orders"),
        Tab(text: "My Task"),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(105);
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        size: 30,
      ),
      onPressed: () {},
    );
  }
}

class _Body extends StatelessWidget {
  final TabController _controller;
  final BlocProcurement bloc = BlocProcurement();

  _Body(this._controller);

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: _controller, children: [
      MyPurchaseOrders(),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownFilter(bloc),
            Divider(),
            PurchaseOrderList(bloc),
          ],
        ),
      )
    ]);
  }
}


class _DropdownFilter extends StatelessWidget {
  final BlocProcurement bloc;

  _DropdownFilter(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: bloc.selected$,
      builder: (ctx, snapshot) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: DropdownButton<String>(
          underline: Container(),
          value: snapshot.data,
          items: statuses
              .map((f) => DropdownMenuItem(child: Text(f), value: f))
              .toList(),
          onChanged: bloc.setSelected,
        ),
      ),
    );
  }
}
