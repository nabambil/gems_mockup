import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockup_gems/route/engineer/route_engineer.dart';
import 'package:mockup_gems/route/procurement/route_procurement.dart';
import 'package:mockup_gems/route/storekeeper/homepage.dart';
import 'package:mockup_gems/route/storekeeper/route_MR.dart';
import 'package:mockup_gems/route/procurement/route_PO.dart';
import 'package:mockup_gems/route/storekeeper/route_PR.dart';
import 'package:mockup_gems/route/storekeeper/route_material_info.dart';
import 'package:mockup_gems/route/storekeeper/route_register.dart';
import 'package:mockup_gems/route/technician/route_technician.dart';
import 'package:mockup_gems/route/technician/route_technician_detail.dart';
import 'package:mockup_gems/utils/bloc/bloc_technician.dart';
import 'package:mockup_gems/utils/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Avenir",
        primaryColor: colorTheme1,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: routeTechnician,
      debugShowCheckedModeBanner: false,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeTechnician:
        if (settings.arguments != null)
          return CupertinoPageRoute(builder: (ctx) => RouteTechnician(value: settings.arguments));
        return CupertinoPageRoute(builder: (ctx) => RouteTechnician());
      case routeTechnicianDetail:
        return CupertinoPageRoute(builder: (ctx) => RouteTechnicianDetail(item:settings.arguments));
      case routeEngineer: 
        final value = BlocTechnician.from(settings.arguments);
        return CupertinoPageRoute(builder: (ctx) => RouteEngineer(value: value));
      case routeInventory:
        return CupertinoPageRoute(builder: (ctx) => Homepage());
      case routeCheckIn: 
        return CupertinoPageRoute(builder: (ctx) => Homepage());
      case routeCheckOut:
        return CupertinoPageRoute(builder: (ctx) => Homepage());
      case routeMaterialInfo:
        return CupertinoPageRoute(builder: (ctx) => MaterialInfo(value: settings.arguments));
      case routeRegisterItem:
        return CupertinoPageRoute(builder: (ctx) => RegisterItem());
      case routePurchaseRequest:
        return CupertinoPageRoute(builder: (ctx) => PurchaseRequest());
      case routePurchaseOrder:
        return CupertinoPageRoute(builder: (ctx) => PurchaseOrder());
      case routeMateralRequest:
        return CupertinoPageRoute(builder: (ctx) => MaterialRequest(status: settings.arguments));
      default:
        return CupertinoPageRoute(builder: (ctx) => ProcumentHomepage());
    }
  }
}