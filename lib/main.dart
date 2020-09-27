
import  'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ProviderShopper_Flutter/common/theme.dart';
import 'package:ProviderShopper_Flutter/models/cart.dart';
import 'package:ProviderShopper_Flutter/models/catalog.dart';
import 'package:ProviderShopper_Flutter/screens/cart.dart';
import 'package:ProviderShopper_Flutter/screens/catalog.dart';
import 'package:ProviderShopper_Flutter/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}