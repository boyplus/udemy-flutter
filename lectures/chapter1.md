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





