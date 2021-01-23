# Udemy Flutter

## Chapter 1

### Introduction to flutter

#### Basic Flutter

**Flutter** is a framework that help us to creat mobile application easily by providing many utilities such as material and cupertino widget, data managemtn. We use **dart** as a programming language to work with flutter. Things that dart provide like other programming language such as main function, data type, OOP concept, libraries like math, convert, async.

#### Advantages of flutter

Flutter can control every pixel of the screen and the code be compiled to the native code that means we can custom as much as we need and have a good performance.

#### Disadvantage of flutter

Since flutter use widget tree to build the components and the widget use concepts of OOP, so we need to remember the attribute name of widget and also remember value of that attribute. Flutter is also verbose (use too much words to create the widget and complete the tasks) For example, create the icon button -> IconButton(icon:Icon(Icons.delete)).

---

### User Interface

#### Introduction to widgets

-> Widget is a component on the screen that control how the screen will look like. The widget tree is the tree of widgets that means there is a root widget such as Scaffold that can contain attributes appBar, body. In addition, root widget can have children (some widget can have many children such as Column, Row, some of them can have only one child).

#### Hello world

-> We use function main() to call runApp() function that receive one parameter which the root widget. In addition, if we would like to create a widget we have to always material (for android) or cupertino (for ios) package.

```dart
import 'package:flutter/material.dart';
void main(){
  runApp(
  	Center(
    	child: Text('Hello, world', textDirection: TextDirection.ltr,),
    ),
  );
}
```

#### Basic Widgets and some keywords

- **SafeArea()** -> Widget that use to properly pad the child the children so it appears below the display on the top of screen (it look not so good in iPhone).
- **MaterialApp()** -> Widget that use to contain the material design widget that the children can inherit the data such as theme from MaterialApp().
- **StatelessWidget** -> Widget that have no state that means the widget on itself will not be rebuild but if the attribute of widget was changed (because the parent of them send the new data that manes the object will be re created)
- **@override** -> It is the notation to describe that we override (re-write) the existing method from the parent class (It is not required to add @override).
- **Widget build(BuildContext context)** -> Method that will automatically call by the flutter that return the widget that we want to display on the screen.
- **context** -> It is the BuildContext that we can receive from the build method. This variable can be use in many situation. In addtion, the context hold the current data of the widget.
- **Expanded** -> expands its child to fill the available screen.

This code is to create the custom AppBar by using widget safeArea() as a container. This code is an only example of combine the widgets together.

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
  final Widget title;
  MyAppBar({this.title});
  @override
  Widget build(BuildContext context){
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizantal: 8),
      child: Row(
      	children: <Widget>[
          IconButton(icon: Icons(Icon.menu), tooltip: 'Navigation Menu', onPressed: null),
          Expanded(
          	child: title,
          ),
          IconButton(icon: Icons(icons.search), tooltip: 'Search', onPressed: null),
        ]
      )
    );
  }
}

class MyScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //Material is a conceptual piece of paper on which the UI appears.
    return Material(
    	child: Column(
      	children: <Widget>[
          MyAppBar(title: Text('Example Title'),
                   style: Theme.of(context).primaryTextTheme.headline6),
          Expanded(child: Center(child: Text('Hello world'))),
        ]
      )
    );
  }
}
void main(){
  runApp(MaterialApp(
  	title: 'My App',
    home: SafeArea(
   		child: MyScaffold(),
    ),
  ));
}
```

***Note**

> We can declare the const object to make sure that this object will not recreate that can help us about performance.

#### Handling Gestures

-> We can use GestureDetector() widget to detect the tap, scale, drags.

```dart
class MyButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GestureDetector(
    	onTap(){
        print('My Button was tapped');
      },
      child: Container(
      	height: 36,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizantal: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.lightGreen[500]),
        child: Center(Text('Engage')),
      ),
    )
  }
}
```

#### Change widget in response to input

-> We can use StatefulWidget to store the state inside the widget that means everytime state be changed, the widget will be rerender (build method was call)

```dart
class Counter extends StatefulWidget{
  //This class is the configuration for the state. It holds the attribute that receive from parent
  //We use createState method to return the Widget (created object)
  //Attribute in this class always marked as final
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter>{
  //This class is the class that we will return our widget
  int _counter = 0;
  void _increment(){
    setState((){
      //We have to call setState() to tell flutter to rerun build method
      //Otherwise although state was change but the widget did not rerender.
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context){
    return Row(
     	children: <Widget>[
        ElevatedButtton(onPressed: _increment, child: Text('Increment')),
        Text('Counter $_counter'),
      ]
    );
  }
}
```

#### Combine widget together

```dart
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

```

-> We can see that on the state widget (_ShoppingListState), we can access to the attribute of StatefulWidget that the parent will provide for it by using widget. for example, the attributes products we can access by the keyword widget.products.

***Note**

> The attribute or any class which marked as _ before their name will be the private (flutter know this)

#### Responding to widget life cycle events

-> After calling **createState()** on StatefulWidget, the flutter insert the new object state in to the tree and then call this method respectively. We can override all of these method, but do not forget to call the original method by using super keyword. such as **super.initState()** after we override the method.

- **initState()** -> to provide some setup in the widget such as fetching data, init the value of state (This method has no idea about the context of widget)
- didChangeDependencies() ->





