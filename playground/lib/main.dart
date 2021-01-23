import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Product {
  final String name;
  Product({this.name});
}

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final Function onCartChanged;
  ShoppingListItem({this.product, this.inCart, this.onCartChanged});

  Color _getColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onCartChanged(product, inCart),
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            child: Text(product.name[0]),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);
  final List<Product> products;
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.remove(product);
      } else {
        _shoppingCart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
      ),
      body: ListView(
        children: widget.products
            .map(
              (el) => ShoppingListItem(
                product: el,
                inCart: _shoppingCart.contains(el),
                onCartChanged: _handleCartChanged,
              ),
            )
            .toList(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playground',
      home: ShoppingList(
        products: [
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate'),
        ],
      ),
    );
  }
}
