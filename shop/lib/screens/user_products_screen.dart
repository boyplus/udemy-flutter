import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './edit_product_screen.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, i) => Column(
            children: <Widget>[
              UserProductItem(
                id: products.items[i].id,
                title: products.items[i].title,
                imageUrl: products.items[i].imageUrl,
              ),
              Divider()
            ],
          ),
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
