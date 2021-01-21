# Udemy Flutter

## Chapter 1

###Introduction to flutter

####Basic Flutter

**Flutter** is a framework that help us to creat mobile application easily by providing many utilities such as material and cupertino widget, data managemtn. We use **dart** as a programming language to work with flutter. Things that dart provide like other programming language such as main function, data type, OOP concept, libraries like math, convert, async.

####Advantages of flutter

Flutter can control every pixel of the screen and the code be compiled to the native code that means we can custom as much as we need and have a good performance.

####Disadvantage of flutter

Since flutter use widget tree to build the components and the widget use concepts of OOP, so we need to remember the attribute name of widget and also remember value of that attribute. Flutter is also verbose (use too much words to create the widget and complete the tasks) For example, create the icon button -> IconButton(icon:Icon(Icons.delete)).

---

###User Interface

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

#### Basic Widgets

- **SafeArea()** -> Widget that use to properly pad the child the children so it appears below the display on the top of screen (it look not so good in iPhone).
- **MaterialApp()** -> Widget that use to contain the material design widget that the children can inherit the data such as theme from MaterialApp().
- **StatelessWidget** -> Widget that have no state that means the widget on itself will not be rebuild but if the attribute of widget was changed (because the parent of them send the new data that manes the object will be re created)
- **@override** -> It is the notation to describe that we override (re-write) the existing method from the parent class (It is not required to add @override).
- **Widget build(BuildContext context)** -> Method that will automatically call by the flutter that return the widget that we want to display on the screen.
- **context** -> It is the BuildContext that we can receive from the build method. This variable can be use in many situation. In addtion, the context hold the current data of the widget.

This code is to create the custom AppBar by using widget safeArea() as a container.

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
  final Widget title;
  MyAppBar({this.title});
  @override
  Widget build(BuildContext context){
    
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


