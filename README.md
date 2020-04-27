# flutter_layout_article

# Flutter: The Advanced Layout Rule Even Beginners Must Know

When someone learning Flutter asks you why some widget with `width:100` is not 100 pixels wide, 
the default answer is to tell them to put that widget inside of a `Center`, right?

**Don't do that!** 

If you do it, they will come back again and again, asking why some `FittedBox` is not working, 
why that `Column` is overflowing, or what `IntrinsicWidth` is supposed to be doing.

Instead, first tell them that Flutter layout is very different from HTML layout 
(which is probably where they're coming from), 
and then make them memorize the following rule:

 
### 👉 Constraints go down. Sizes go up. Positions are set by parents.

Flutter layout can't really be understood without knowing this rule, 
so I believe everyone should learn it early on.

In more detail: 

* A widget gets its own constraints from its parent. 
A "constraint" is just a set of 4 doubles: a minimum and maximum **width**, 
as well as a minimum and maximum **height**. 

* Then the widget goes through its own list of children. One by one, 
the widget tells its children what are their constraints (which can be different for each child), 
and then asks each child which size it wants to be.

* Then, the widget positions its children 
(horizontally in the `x` axis, and vertically in the `y` axis),
one by one.

* And, finally, the widget tells its parent about its own size 
(within the original constraints, of course).

<br>

If a widget is like a column with some padding, and wants to layout its two children:

><img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/layoutExample.png" width="903" height="394"></img>
>
> **Widget** — Hey parent, what are my constraints?      
>
> **Parent** — You must be between `90`→`300` wide, and `30`→`85` tall.
> 
> **Widget** — Hm, since I want to have `5` pixels of padding, then my children can have at most `290` pixels of width and `75` pixels of height. 
> 
> **Widget** — Hey first child, You must be between `0`→`290` wide, and `0`→`75` pixels tall.
>
> **First Child** — Ok, I wish to be `290` pixels wide, and `20` pixels tall.
>
> **Widget** — Hm, since I want to put my second child below the first one, this leaves only `55` pixels of height for my second child.
>                                                                                                           
> **Widget** — Hey second child, You must be between `0`→`290` wide, and between `0`→`55` tall.
>                
> **Second Child** — Ok, I wish to be `140` pixels wide, and `30` pixels tall.
>
> **Widget** — Very Well. I will put my fist child into position `x: 5` and `y: 5`, and my second child into position `x: 80` and `y: 25`.
> 
> **Widget** — Hey parent, I've decided that my size is going to be `300` pixels wide, and `60` pixels tall.

## Limitations

As a result of the above described layout rule, Flutter's layout engine has a few important limitations:

* A widget can decide its own size only within the constraints given to it by its parent. 
This means a widget usually **cannot have any size it wants**. 

* A widget **can't know and doesn't decide its own position in the screen**, since it's the widget's parent who will decide the position of the widget.

* Since the parent's size and position, in its turn, also depends on its own parent, 
it's impossible to precisely define the size and position of any widget 
without taking into consideration the tree as a whole.


# Examples

For an interactive experience, run <a href="https://dartpad.dev/60174a95879612e500203084a0588f94">this DartPad</a> (there is also <a href="https://github.com/marcglasberg/flutter_layout_article">this GitHub repo</a>).


## Example 1

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example1.png" width="320"></img>

```dart 
Container(color: red)
```
 
The screen is the parent of the `Container`. 
It forces the red `Container` to be exactly the same size of the screen.
       
So the `Container` fills the screen and it gets all red.


## Example 2

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example2.png" width="320"></img>

```dart                 
Container(width: 100, height: 100, color: red)
```           

The red `Container` wants to be 100x100, but it can't,
because the screen forces it to be exactly the same size of the screen.
      
So the `Container` fills the screen.


## Example 3

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example3.png" width="320"></img>

```dart                
Center(
   child: Container(width: 100, height: 100, color: red))
```            

The screen forces the `Center` to be exactly the same size of the screen.

So the `Center` fills the screen.

The `Center` tells the `Container` it can be any size it wants, but not bigger than the screen.

Now the `Container` can indeed be 100x100.


## Example 4

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example4.png" width="320"></img>

```dart                
Align(
   alignment: Alignment.bottomRight,
   child: `Container`(width: 100, height: 100, color: red))
```            

  
This is different from the previous example in that it uses `Align` instead of `Center`.
      
The `Align` also tells the `Container` it can be any size it wants, 
but if there is empty space it will not center the `Container`, 
but will instead align it to the bottom-right of the available space.


## Example 5
          
<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example5.png" width="320"></img>
          
```dart
Center(
   child: Container(
            color: red,
            width: double.infinity,
            height: double.infinity)) 
```
                           
The screen forces the `Center` to be exactly the same size of the screen.

So the `Center` fills the screen.

The `Center` tells the `Container` it can be any size it wants, but not bigger than the screen.

The `Container` wants to be of infinite size, but since it can't be bigger than the screen, 
it will just fill the screen.


## Example 6

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example6.png" width="320"></img>

```dart                
Center(child: Container(color: red))
```                   

The screen forces the `Center` to be exactly the same size of the screen.

So the `Center` fills the screen.

The `Center` tells the `Container` it is free to be any size it wants, but not bigger than the screen.

Since the `Container` has no child and no fixed size, it decides it wants to be as big as possible, 
so it fits the whole screen.

But why does the `Container` decide that? 
Simply because that's a design decision by those who created the `Container` widget. 
It could have been created differently,
and you actually have to read the `Container`'s documentation 
to understand what it will do depending on the circumstances.


## Example 7

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example7.png" width="320"></img>

```dart 
Center(
   child: Container(color: red
      child: Container(color: green, width: 30, height: 30)))
```        

The screen forces the `Center` to be exactly the same size of the screen.

So the `Center` fills the screen.

The `Center` tells the red `Container` it can be any size it wants, but not bigger than the screen.

Since the red `Container` has no size but has a child, it decides it wants to be the same size of its child.

The red `Container` tells its child that if can be any size it wants, but not bigger than the screen.

The child happens to be a green `Container`, that wants to be 30x30.

As said, the red `Container` will size itself to its children size, so it will also be 30x30. 
No red color will be visible, since the green `Container` will occupy all of the red `Container`.


## Example 8

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example8.png" width="320"></img>

```dart 
Center(
   child: Container(color: red
      padding: const EdgeInsets.all(20.0),
      child: Container(color: green, width: 30, height: 30)))
```                  

The red `Container` will size itself to its children size, but it takes its own padding into consideration. 
So it will also be 30x30 plus padding. 
The red color will be visible because of the padding, 
and the green `Container` will have the same size as the previous example.


## Example 9

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example9.png" width="320"></img>

```dart 
ConstrainedBox(
   constraints: BoxConstraints(
              minWidth: 70, minHeight: 70,
              maxWidth: 150, maxHeight: 150),
      child: Container(color: red, width: 10, height: 10)))
```         

You would guess the `Container` would have to be between 70 and 150 pixels, but you would be wrong. 
The ConstrainedBox only imposes **additional** constraints than the ones it received from its parent.

Here, the screen forces the `ConstrainedBox` to be exactly the same size of the screen, 
so it will tell its child `Container` to also assume the size of the screen, 
thus ignoring its `constraints` parameter.


## Example 10

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example10.png" width="320"></img>

```dart 
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
                 minWidth: 70, minHeight: 70,
                 maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 10, height: 10))))
```                            

Now, `Center` will allow `ConstrainedBox` to be any size up to the screen size.

The `ConstrainedBox` will impose its child the **additional** constraints from its `constraints` parameter.

So the `Container` must be between 70 and 150 pixels. 
It wants to have 10 pixels, so it will end up having 70 (the **minimum**).


## Example 11

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example11.png" width="320"></img>

```dart 
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
                 minWidth: 70, minHeight: 70,
                 maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 1000, height: 1000))))
```             

`Center` will allow `ConstrainedBox` to be any size up to the screen size.

The `ConstrainedBox` will impose its child the **additional** constraints from its `constraints` parameter.

So the `Container` must be between 70 and 150 pixels. 
It wants to have 1000 pixels, so it will end up having 150 (the **maximum**).


## Example 12

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example12.png" width="320"></img>

```dart 
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
                 minWidth: 70, minHeight: 70,
                 maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 100, height: 100))))
```             

`Center` will allow `ConstrainedBox` to be any size up to the screen size.

The `ConstrainedBox` will impose its child the **additional** constraints from its `constraints` parameter.

So the `Container` must be between 70 and 150 pixels. 
It wants to have 100 pixels, and that's the size it will have, since that's between 70 and 150.


## Example 13

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example13.png" width="320"></img>

```dart 
UnconstrainedBox(
   child: Container(color: red, width: 20, height: 50))
```

The screen forces the `UnconstrainedBox` to be exactly the same size of the screen.

However, the `UnconstrainedBox` lets its `Container` child have any size it wants.


## Example 14

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example14.png" width="320"></img>

```dart 
UnconstrainedBox(
   child: Container(color: red, width: 4000, height: 50));
```                 

The screen forces the `UnconstrainedBox` to be exactly the same size of the screen, 
and `UnconstrainedBox` lets its `Container` child have any size it wants.

Unfortunately, in this case the `Container` has 4000 pixels of width 
and is too big to fit in the `UnconstrainedBox`, 
so the `UnconstrainedBox` will display the much dreaded "overflow warning".


## Example 15

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example15.png" width="320"></img>

```dart 
OverflowBox(
   child: Container(color: red, width: 4000, height: 50));
```                        

The screen forces the `OverflowBox` to be exactly the same size of the screen, 
and `OverflowBox` lets its `Container` child have any size it wants.

OverflowBox is similar to `UnconstrainedBox`, 
and the difference is that it won't display any warnings if the child doesn't fit the space.

In this case the `Container` has 4000 pixels of width, and is too big to fit in the `OverflowBox`, 
but the `OverflowBox` will simply show what it can, no warnings given.


## Example 16

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example16.png" width="320"></img>

```dart 
UnconstrainedBox(
   child: Container(color: Colors.red, width: double.infinity, height: 100))
```            

This won't render anything, and you will get an error in the console.

The `UnconstrainedBox` lets its child have any size it wants, 
however its child is a `Container` with infinite size.

Flutter can't render infinite sizes, so it will throw an error with the following message: 
`BoxConstraints forces an infinite width.`


## Example 17

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example17.png" width="320"></img>

```dart 
UnconstrainedBox(
   child: LimitedBox(maxWidth: 100,
      child: Container(color: Colors.red,
                       width: double.infinity, height: 100))
```              

Here you won't get an error anymore, 
because when the `LimitedBox` is given an infinite size by the `UnconstrainedBox`, 
it will pass down to its child the maximum width of 100.

Note, if you change the `UnconstrainedBox` to a `Center` widget, 
the `LimitedBox` will not apply its limit anymore (since its limit is only applied when it gets infinite constraints), 
and the `Container` width will be allowed to grow past 100.

This makes it clear the difference between a `LimitedBox` and a `ConstrainedBox`.


## Example 18

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example18.png" width="320"></img>

```dart 
FittedBox(
   child: Text('Some Example Text.'))
```             

The screen forces the `FittedBox` to be exactly the same size of the screen.

The `Text` will have some natural width (also called its intrinsic width) that depends on the amount of text, 
its font size, etc.

The `FittedBox` will let the `Text` have any size it wants, 
but after the `Text` tells its size to the `FittedBox`, 
the `FittedBox` will scale it until it fills all of the available width.


## Example 19

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example19.png" width="320"></img>

```dart 
Center(
   child: FittedBox(
      child: Text('Some Example Text.')))
```   

But what happens if we put the `FittedBox` inside of a `Center`? 
The `Center` will let the `FittedBox` have any size it wants, up to the screen size.

The `FittedBox` will then size itself to the `Text`, and let the `Text` have any size it wants.

Since both `FittedBox` and the `Text` have the same size, no scaling will happen.


## Example 20

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example20.png" width="320"></img>

```dart 
Center(
   child: FittedBox(
      child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.')))
```       

However, what happens if `FittedBox` is inside of `Center`, but the `Text` is too large to fit the screen?

`FittedBox` will try to size itself to the `Text`, but it cannot be bigger than the screen. 
It will then assume the screen size, and resize the `Text` so that it fits the screen too.


## Example 21

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example21.png" width="320"></img>

```dart 
Center(
   child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.'))
```                

If, however, we remove the `FittedBox`, 
the `Text` will get its maximum width from the screen, 
and will break the line so that it fits the screen.


## Example 22

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example22.png" width="320"></img>

```dart            
FittedBox(
   child: Container(
      height: 20.0, width: double.infinity))
```

Note `FittedBox` can only scale a widget that is **bounded** (has non infinite width and height).

Otherwise, it won't render anything, and you will get an error in the console.


## Example 23

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example23.png" width="320"></img>

```dart 
Row(children:[
       Container(color: red, child: Text('Hello!'))
       Container(color: green, child: Text('Goodbye!'))]
```               

The screen forces the `Row` to be exactly the same size of the screen.

Just like an `UnconstrainedBox`, the `Row` won't impose any constraints to its children, 
and will instead let them have any size they want.

The `Row` will then put them side by side, and any extra space will remain empty.


## Example 24

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example24.png" width="320"></img>

```dart 
Row(children:[
      Container(color: red, child: Text('This is a very long text that won't fit the line.'))
      Container(color: green, child: Text('Goodbye!'))]
```                    

Since the `Row` won't impose any constraints to its children, 
it's quite possible that the children will be too big to fit the available `Row` width.

In this case, just like an `UnconstrainedBox`, the `Row` will display the \"overflow warning\".


## Example 25

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example25.png" width="320"></img>

```dart 
Row(children:[
   Expanded(
       child: Container(color: red, child: Text('This is a very long text that won't fit the line.')))
   Container(color: green, child: Text('Goodbye!'))]
```                                   

When a `Row` child is wrapped in an `Expanded` widget, the `Row` will not let this child define its own width anymore.

Instead, it will define the `Expanded` width according to the other children, 
and only then the `Expanded` widget will force the original child to have the `Expanded`'s width.

In other words, once you use `Expanded`, the original child's width becomes irrelevant, and will be ignored.


## Example 26

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example26.png" width="320"></img>

```dart          
Row(children:[
   Expanded(
       child: Container(color: red, child: Text('This is a very long text that won't fit the line.')))
   Expanded(
       child: Container(color: green, child: Text('Goodbye!'))]
```

If all `Row` children are wrapped in `Expanded` widgets, 
each `Expanded` will have a size proportional to its flex parameter, 
and only then each `Expanded` widget will force their child to have the `Expanded`'s width.

In other words, the `Expanded` ignores their children preferred width.


## Example 27

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example27.png" width="320"></img>

```dart 
Row(children:[
   Flexible(
       child: Container(color: red, child: Text('This is a very long text that won't fit the line.')))
   Flexible(
       child: Container(color: green, child: Text('Goodbye!'))]
```              

The only difference if you use `Flexible` instead of `Expanded`, 
is that `Flexible` will let its child have the **same or smaller** width than the `Flexible` itself, 
while `Expanded` forces its child to have the **exact same** width of the `Expanded`.

But both `Expanded` and `Flexible` will ignore their children widths when sizing themselves.

Note, this means it's **impossible** to expand `Row` children proportionally to their sizes. 
The `Row` will either use the exact child's with, or ignore it completely when you use `Expanded` or `Flexible`.


## Example 28

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example28.png" width="320"></img>

```dart 
Scaffold(
   body: Container(
      color: blue,
      child: Column(
         children: [
            Text('Hello!'),
            Text('Goodbye!'),
         ])))
```           

The screen forces the `Scaffold` to be exactly the same size of the screen.

So the `Scaffold` fills the screen.

The `Scaffold` tells the `Container` it can be any size it wants, but not bigger than the screen.
      
Note: When a widget tells its child it can be smaller than a certain size, 
we say the widget supplies "loose" constraints to its child. More on that in the article.   


## Example 29

<img src="https://raw.githubusercontent.com/marcglasberg/flutter_layout_article/master/images/example29.png" width="320"></img>

```dart 
Scaffold(
   body: SizedBox.expand(
      child: Container(
         color: blue,
         child: Column(
            children: [
               Text('Hello!'),
               Text('Goodbye!'),
            ]))))
```           

If we want the `Scaffold`'s child to be exactly the same size as the `Scaffold` itself, 
we can wrap its child into a `SizedBox.expand`.
      
Note: When a widget tells its child it must be of a certain size, 
we say the widget supplies "tight" constraints to its child. More on that in the article.


# Tight × Loose Constraints

It's very common to hear that some constraint is "tight" or "loose", 
so it's worth knowing what it means.

<br>

A **tight** constraint offers a single possibility. An **exact** size. 
In other words, a tight constraint has its maximum width equal to its minimum width;
and has its maximum height equal to its minimum height.

If you go to Flutter's `box.dart` file and search for the `BoxConstraints` constructors,
you will find this:

```dart                    
BoxConstraints.tight(Size size)
   : minWidth = size.width,
     maxWidth = size.width,
     minHeight = size.height,
     maxHeight = size.height;
```                                                    

If you revisit the **Example 2** further above, 
it tells us that the screen forces the red `Container` to be exactly the same size of the screen.
The screen does that, of course, by passing **tight** constraints to the `Container`.  

<br>

A **loose** constraint, on the other hand, sets the **maximum** width/height, 
but lets the widget be as small as it wants. 
In other words, a loose constraint has **minimum** width/height both equal to **zero**:


```dart                    
BoxConstraints.loose(Size size)
   : minWidth = 0.0,
     maxWidth = size.width,
     minHeight = 0.0,
     maxHeight = size.height;
```  

If you revisit the **Example 3**, 
it tells us that the `Center` lets the red `Container` be smaller, but not bigger than the screen.
The `Center` does that, of course, by passing **loose** constraints to the `Container`.

If you revisit the **Example 3**, 
it tells us that the `Center` lets the red `Container` be smaller, but not bigger than the screen. 
The `Center` does that, of course, by passing **loose** constraints to the `Container`. 
Ultimately, the `Center`'s very purpose 
is to transform the tight constraints it got from its parent (the screen) 
to loose constraints for its child (the `Container`).


# Learning the layout rules for specific widgets

Knowing the general layout rule is necessary, but it's not enough. 

Each widget has a lot of freedom when applying the general rule, 
so there is no way of knowing what it will do by just reading the widget's name.
If you try to guess, you'll probably guess wrong. 
You can't know exactly how a widget will behave unless you've read its documentation, or studied its source-code.

The layout source-code is usually complex, so it's probably better to just read the documentation. 
However, if you decide to study the layout source-code, 
you can easily find it by using the navigating capabilities of your IDE. 

Here is an example:

* Find some `Column` in your code and navigate to its source-code (`Ctrl-B` in IntelliJ). 
You'll be taken to the `basic.dart` file. Since `Column` extends `Flex`, navigate to `Flex` source-code (also in `basic.dart`).

* Now scroll down until you find a method called `createRenderObject`. 
As you can see, this method returns a `RenderFlex`. This is the corresponding render-object for the `Column`.
Now navigate to the source-code of `RenderFlex`, which will take you to the `flex.dart` file.  

* Now scroll down until you find a method called `performLayout`. 
This is the method which does the layout for the `Column`.

*********************

*Layout packages I've authored:*
* <a href="https://pub.dev/packages/align_positioned">align_positioned</a> — Lets you declaratively position/size widgets in complex ways.
* <a href="https://pub.dev/packages/assorted_layout_widgets">assorted_layout_widgets</a> — Includes `RowSuper` which will resize cells proportionately when content doesn't fit.

*Other Flutter packages I've authored:* 
* <a href="https://pub.dev/packages/async_redux">async_redux</a>
* <a href="https://pub.dev/packages/provider_for_redux">provider_for_redux</a>
* <a href="https://pub.dev/packages/i18n_extension">i18n_extension</a>
* <a href="https://pub.dev/packages/network_to_file_image">network_to_file_image</a>
* <a href="https://pub.dev/packages/matrix4_transform">matrix4_transform</a> 
* <a href="https://pub.dev/packages/back_button_interceptor">back_button_interceptor</a>
* <a href="https://pub.dev/packages/indexed_list_view">indexed_list_view</a> 
* <a href="https://pub.dev/packages/animated_size_and_fade">animated_size_and_fade</a>

<br>_Marcelo Glasberg:_<br>
_https://github.com/marcglasberg_<br>
_https://twitter.com/glasbergmarcelo_<br>
_https://stackoverflow.com/users/3411681/marcg_<br>
_https://medium.com/@marcglasberg_<br>
 


