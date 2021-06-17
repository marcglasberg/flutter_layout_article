import 'package:flutter/material.dart';

void main() => runApp(HomePage());

const red = Colors.red;
const green = Colors.green;
const blue = Colors.blue;
const big = const TextStyle(fontSize: 30);

//////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FlutterLayoutArticle(<Example>[
        Example1(),
        Example2(),
        Example3(),
        Example4(),
        Example5(),
        Example6(),
        Example7(),
        Example8(),
        Example9(),
        Example10(),
        Example11(),
        Example12(),
        Example13(),
        Example14(),
        Example15(),
        Example16(),
        Example17(),
        Example18(),
        Example19(),
        Example20(),
        Example21(),
        Example22(),
        Example23(),
        Example24(),
        Example25(),
        Example26(),
        Example27(),
        Example28(),
        Example29(),
      ]);
}

//////////////////////////////////////////////////

abstract class Example extends StatelessWidget {
  String get code;

  String get explanation;
}

//////////////////////////////////////////////////

class FlutterLayoutArticle extends StatefulWidget {
  final List<Example> examples;

  FlutterLayoutArticle(this.examples);

  @override
  _FlutterLayoutArticleState createState() => _FlutterLayoutArticleState();
}

//////////////////////////////////////////////////

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  late int count;
  late Widget example;
  late String code;
  late String explanation;

  @override
  void initState() {
    count = 1;
    code = Example1().code;
    explanation = Example1().explanation;

    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Article',
      home: SafeArea(
        child: Material(
          color: Colors.black,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: Color(0xFFCCCCCC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: double.infinity, height: double.infinity),
                        child: widget.examples[count - 1]),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.examples.length; i++)
                            Container(
                              width: 58,
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: button(i + 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          key: ValueKey(count),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text(code)),
                                SizedBox(height: 15),
                                Text(
                                  explanation,
                                  style: TextStyle(
                                      color: Colors.blue[900],
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      height: 273,
                      color: Colors.grey[200]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(int exampleNumber) => Button(
        key: ValueKey("button$exampleNumber"),
        isSelected: this.count == exampleNumber,
        exampleNumber: exampleNumber,
        onPressed: () {
          showExample(
            exampleNumber,
            widget.examples[exampleNumber - 1].code,
            widget.examples[exampleNumber - 1].explanation,
          );
        },
      );

  void showExample(int exampleNumber, String code, String explanation) =>
      setState(() {
        this.count = exampleNumber;
        this.code = code;
        this.explanation = explanation;
      });
}

//////////////////////////////////////////////////

class Button extends StatelessWidget {
  final Key key;
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  Button({
    required this.key,
    required this.isSelected,
    required this.exampleNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: isSelected ? Colors.grey : Colors.grey[800],
        child: Text(exampleNumber.toString(),
            style: TextStyle(color: Colors.white)),
        onPressed: () {
          Scrollable.ensureVisible(
            context,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
            alignment: 0.5,
          );
          onPressed();
        });
  }
}
//////////////////////////////////////////////////

class Example1 extends Example {
  final String code = "Container(color: red)";
  final String explanation = "The screen is the parent of the Container. "
      "It forces the red Container to be exactly the same size of the screen."
      "\n\n"
      "So the Container fills the screen and it gets all red.";

  @override
  Widget build(BuildContext context) {
    return Container(color: red);
  }
}

//////////////////////////////////////////////////

class Example2 extends Example {
  final String code = "Container(width: 100, height: 100, color: red)";
  final String explanation =
      "The red Container wants to be 100x100, but it can't, "
      "because the screen forces it to be exactly the same size of the screen."
      "\n\n"
      "So the Container fills the screen.";

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: red);
  }
}

//////////////////////////////////////////////////

class Example3 extends Example {
  final String code = "Center(\n"
      "   child: Container(width: 100, height: 100, color: red))";
  final String explanation =
      "The screen forces the Center to be exactly the same size of the screen."
      "\n\n"
      "So the Center fills the screen."
      "\n\n"
      "The Center tells the Container it can be any size it wants, but not bigger than the screen."
      "\n\n"
      "Now the Container can indeed be 100x100.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example4 extends Example {
  final String code = "Align(\n"
      "   alignment: Alignment.bottomRight,\n"
      "   child: Container(width: 100, height: 100, color: red))";
  final String explanation =
      "This is different from the previous example in that it uses Align instead of Center."
      "\n\n"
      "The Align also tells the Container it can be any size it wants, but if there is empty space it will not center the Container, "
      "but will instead align it to the bottom-right of the available space.";

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example5 extends Example {
  final String code = "Center(\n"
      "   child: Container(\n"
      "              color: red,\n"
      "              width: double.infinity,\n"
      "              height: double.infinity))";
  final String explanation =
      "The screen forces the Center to be exactly the same size of the screen."
      "\n\n"
      "So the Center fills the screen."
      "\n\n"
      "The Center tells the Container it can be any size it wants, but not bigger than the screen."
      "\n\n"
      "The Container wants to be of infinite size, but since it can't be bigger than the screen it will just fill the screen.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity, height: double.infinity, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example6 extends Example {
  final String code = "Center(child: Container(color: red))";
  final String explanation =
      "The screen forces the Center to be exactly the same size of the screen."
      "\n\n"
      "So the Center fills the screen."
      "\n\n"
      "The Center tells the Container it is free to be any size it wants, but not bigger than the screen."
      "\n\n"
      "Since the Container has no child and no fixed size, it decides it wants to be as big as possible, so it fits the whole screen."
      "\n\n"
      "But why does the Container decide that? "
      "Simply because that's a design decision by those who created the Container widget. "
      "It could have been created differently, and you actually have to read the Container's documentation to understand what it will do depending on the circumstances. ";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example7 extends Example {
  final String code = "Center(\n"
      "   child: Container(color: red\n"
      "      child: Container(color: green, width: 30, height: 30)))";
  final String explanation =
      "The screen forces the Center to be exactly the same size of the screen."
      "\n\n"
      "So the Center fills the screen."
      "\n\n"
      "The Center tells the red Container it can be any size it wants, but not bigger than the screen."
      "\n\n"
      "Since the red Container has no size but has a child, it decides it wants to be the same size of its child."
      "\n\n"
      "The red Container tells its child that if can be any size it wants, but not bigger than the screen."
      "\n\n"
      "The child happens to be a green Container, that wants to be 30x30."
      "\n\n"
      "As said, the red Container will size itself to its children size, so it will also be 30x30. "
      "No red color will be visible, since the green Container will occupy all of the red Container.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example8 extends Example {
  final String code = "Center(\n"
      "   child: Container(color: red\n"
      "      padding: const EdgeInsets.all(20.0),\n"
      "      child: Container(color: green, width: 30, height: 30)))";
  final String explanation =
      "The red Container will size itself to its children size, but it takes its own padding into consideration. "
      "So it will also be 30x30, plus a 20x20 padding. "
      "The red color will be visible because of the padding, and the green Container will have the same size as the previous example.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example9 extends Example {
  final String code = "ConstrainedBox(\n"
      "   constraints: BoxConstraints(\n"
      "              minWidth: 70, minHeight: 70,\n"
      "              maxWidth: 150, maxHeight: 150),\n"
      "      child: Container(color: red, width: 10, height: 10)))";
  final String explanation =
      "You would guess the Container would have to be between 70 and 150 pixels, but you would be wrong. "
      "The ConstrainedBox only imposes ADDITIONAL constraints than the ones it received from its parent."
      "\n\n"
      "Here, the screen forces the ConstrainedBox to be exactly the same size of the screen, "
      "so it will tell its child Container to also assume the size of the screen, "
      "thus ignoring its 'constraints' parameter.";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
      child: Container(color: red, width: 10, height: 10),
    );
  }
}

//////////////////////////////////////////////////

class Example10 extends Example {
  final String code = "Center(\n"
      "   child: ConstrainedBox(\n"
      "      constraints: BoxConstraints(\n"
      "                 minWidth: 70, minHeight: 70,\n"
      "                 maxWidth: 150, maxHeight: 150),\n"
      "        child: Container(color: red, width: 10, height: 10))))";
  final String explanation =
      "Now, Center will allow ConstrainedBox to be any size up to the screen size."
      "\n\n"
      "The ConstrainedBox will impose its child the ADDITIONAL constraints from its 'constraints' parameter."
      "\n\n"
      "So the Container must be between 70 and 150 pixels. It wants to have 10 pixels, so it will end up having 70 (the MINIMUM).";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 10, height: 10),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example11 extends Example {
  final String code = "Center(\n"
      "   child: ConstrainedBox(\n"
      "      constraints: BoxConstraints(\n"
      "                 minWidth: 70, minHeight: 70,\n"
      "                 maxWidth: 150, maxHeight: 150),\n"
      "        child: Container(color: red, width: 1000, height: 1000))))";
  final String explanation =
      "Center will allow ConstrainedBox to be any size up to the screen size."
      "\n\n"
      "The ConstrainedBox will impose its child the ADDITIONAL constraints from its 'constraints' parameter."
      "\n\n"
      "So the Container must be between 70 and 150 pixels. It wants to have 1000 pixels, so it will end up having 150 (the MAXIMUM).";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 1000, height: 1000),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example12 extends Example {
  final String code = "Center(\n"
      "   child: ConstrainedBox(\n"
      "      constraints: BoxConstraints(\n"
      "                 minWidth: 70, minHeight: 70,\n"
      "                 maxWidth: 150, maxHeight: 150),\n"
      "        child: Container(color: red, width: 100, height: 100))))";
  final String explanation =
      "Center will allow ConstrainedBox to be any size up to the screen size."
      "\n\n"
      "The ConstrainedBox will impose its child the ADDITIONAL constraints from its 'constraints' parameter."
      "\n\n"
      "So the Container must be between 70 and 150 pixels. It wants to have 100 pixels, and that's the size it will have, since that's between 70 and 150.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 100, height: 100),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example13 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: Container(color: red, width: 20, height: 50));";
  final String explanation =
      "The screen forces the UnconstrainedBox to be exactly the same size of the screen."
      "\n\n"
      "However, the UnconstrainedBox lets its Container child have any size it wants.";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 20, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example14 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: Container(color: red, width: 4000, height: 50));";
  final String explanation =
      "The screen forces the UnconstrainedBox to be exactly the same size of the screen, "
      "and UnconstrainedBox lets its Container child have any size it wants."
      "\n\n"
      "Unfortunately, in this case the Container has 4000 pixels of width and is too big to fix UnconstrainedBox, "
      "so the UnconstrainedBox will display the much dreaded \"overflow warning\".";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example15 extends Example {
  final String code = "OverflowBox(\n"
      "   child: Container(color: red, width: 4000, height: 50));";
  final String explanation =
      "The screen forces the OverflowBox to be exactly the same size of the screen, "
      "and OverflowBox lets its Container child have any size it wants."
      "\n\n"
      "OverflowBox is similar to UnconstrainedBox, and the difference is that it won't display any warnings if the child doesn't fit the space."
      "\n\n"
      "In this case the Container has 4000 pixels of width, and is too big to fix OverflowBox, "
      "but the OverflowBox will simply show what it can, no warnings given.";

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0.0,
      minHeight: 0.0,
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example16 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: Container(color: Colors.red, width: double.infinity, height: 100));";
  final String explanation =
      "This won't render anything, and you will get an error in the console."
      "\n\n"
      "The UnconstrainedBox lets its child have any size it wants, "
      "however its child is a Container with infinite size."
      "\n\n"
      "Flutter can't render infinite sizes, so it will throw an error with the following message: "
      "'BoxConstraints forces an infinite width.'";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: Colors.red, width: double.infinity, height: 100),
    );
  }
}

//////////////////////////////////////////////////

class Example17 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: LimitedBox(maxWidth: 100,\n"
      "      child: Container(color: Colors.red,\n"
      "                       width: double.infinity, height: 100));";
  final String explanation = "Here you won't get an error anymore, "
      "because when the LimitedBox is given an infinite size by the UnconstrainedBox, "
      "it will pass down to its child the maximum width of 100."
      "\n\n"
      "Note, if you change the UnconstrainedBox to a Center widget, "
      "the LimitedBox will not apply its limit anymore (since its limit is only applied when it gets infinite constraints), "
      "and the Container width will be allowed to grow past 100."
      "\n\n"
      "This makes it clear the difference between a LimitedBox and a ConstrainedBox.";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: LimitedBox(
        maxWidth: 100,
        child:
            Container(color: Colors.red, width: double.infinity, height: 100),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example18 extends Example {
  final String code = "FittedBox(\n"
      "   child: Text('Some Example Text.'));";
  final String explanation =
      "The screen forces the FittedBox to be exactly the same size of the screen."
      "\n\n"
      "The Text will have some natural width (also called its intrinsic width) that depends on the amount of text, its font size, etc."
      "\n\n"
      "The FittedBox will let the Text have any size it wants, "
      "but after the Text tells its size to the FittedBox, "
      "the FittedBox will scale it until it fills all of the available width.";

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text("Some Example Text."),
    );
  }
}

//////////////////////////////////////////////////

class Example19 extends Example {
  final String code = "Center(\n"
      "   child: FittedBox(\n"
      "      child: Text('Some Example Text.')));";
  final String explanation =
      "But what happens if we put the FittedBox inside of a Center? "
      "The Center will let the FittedBox have any size it wants, up to the screen size."
      "\n\n"
      "The FittedBox will then size itself to the Text, and let the Text have any size it wants."
      "\n\n"
      "Since both FittedBox and the Text have the same size, no scaling will happen.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text("Some Example Text."),
      ),
    );
  }
}

////////////////////////////////////////////////////

class Example20 extends Example {
  final String code = "Center(\n"
      "   child: FittedBox(\n"
      "      child: Text('…')));";
  final String explanation =
      "However, what happens if FittedBox is inside of Center, but the Text is too large to fit the screen?"
      "\n\n"
      "FittedBox will try to size itself to the Text, but it cannot be bigger than the screen. "
      "It will then assume the screen size, and resize the Text so that it fits the screen too.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text(
            "This is some very very very large text that is too big to fit a regular screen in a single line."),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example21 extends Example {
  final String code = "Center(\n"
      "   child: Text('…'));";
  final String explanation = "If, however, we remove the FittedBox, "
      "the Text will get its maximum width from the screen, "
      "and will break the line so that it fits the screen.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "This is some very very very large text that is too big to fit a regular screen in a single line."),
    );
  }
}

//////////////////////////////////////////////////

class Example22 extends Example {
  final String code = "FittedBox(\n"
      "   child: Container(\n"
      "      height: 20.0, width: double.infinity));";
  final String explanation =
      "Note FittedBox can only scale a widget that is BOUNDED (has non infinite width and height)."
      "\n\n"
      "Otherwise, it won't render anything, and you will get an error in the console.";

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 20.0,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example23 extends Example {
  final String code = "Row(children:[\n"
      "   Container(color: red, child: Text('Hello!'))\n"
      "   Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "The screen forces the Row to be exactly the same size of the screen."
      "\n\n"
      "Just like an UnconstrainedBox, the Row won't impose any constraints to its children, "
      "and will instead let them have any size they want."
      "\n\n"
      "The Row will then put them side by side, and any extra space will remain empty.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(color: red, child: Text("Hello!", style: big)),
        Container(color: green, child: Text("Goodbye!", style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example24 extends Example {
  final String code = "Row(children:[\n"
      "   Container(color: red, child: Text('…'))\n"
      "   Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "Since the Row won't impose any constraints to its children, "
      "it's quite possible that the children will be too big to fit the available Row width."
      "\n\n"
      "In this case, just like an UnconstrainedBox, the Row will display the \"overflow warning\".";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            color: red,
            child: Text("This is a very long text that won't fit the line.",
                style: big)),
        Container(color: green, child: Text("Goodbye!", style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example25 extends Example {
  final String code = "Row(children:[\n"
      "   Expanded(\n"
      "       child: Container(color: red, child: Text('…')))\n"
      "   Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "When a Row child is wrapped in an Expanded widget, the Row will not let this child define its own width anymore."
      "\n\n"
      "Instead, it will define the Expanded width according to the other children, and only then the Expanded widget will force the original child to have the Expanded's width."
      "\n\n"
      "In other words, once you use Expanded, the original child's width becomes irrelevant, and will be ignored.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
          child: Container(
              color: red,
              child: Text("This is a very long text that won't fit the line.",
                  style: big)),
        )),
        Container(color: green, child: Text("Goodbye!", style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example26 extends Example {
  final String code = "Row(children:[\n"
      "   Expanded(\n"
      "       child: Container(color: red, child: Text('…')))\n"
      "   Expanded(\n"
      "       child: Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "If all Row children are wrapped in Expanded widgets, each Expanded will have a size proportional to its flex parameter, "
      "and only then each Expanded widget will force their child to have the Expanded's width."
      "\n\n"
      "In other words, the Expanded ignores their children preferred width.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                color: red,
                child: Text("This is a very long text that won't fit the line.",
                    style: big))),
        Expanded(
            child:
                Container(color: green, child: Text("Goodbye!", style: big))),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example27 extends Example {
  final String code = "Row(children:[\n"
      "   Flexible(\n"
      "       child: Container(color: red, child: Text('…')))\n"
      "   Flexible(\n"
      "       child: Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "The only difference if you use Flexible instead of Expanded, "
      "is that Flexible will let its child be SMALLER than the Flexible width, "
      "while Expanded forces its child to have the same width of the Expanded."
      "\n\n"
      "But both Expanded and Flexible will ignore their children width when sizing themselves."
      "\n\n"
      "Note, this means it's IMPOSSIBLE to expand Row children proportionally to their sizes. "
      "The Row will either use the exact child's with, or ignore it completely when you use Expanded or Flexible.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
                color: red,
                child: Text("This is a very long text that won't fit the line.",
                    style: big))),
        Flexible(
            child:
                Container(color: green, child: Text("Goodbye!", style: big))),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example28 extends Example {
  final String code = "Scaffold(\n"
      "   body: Container(color: blue,\n"
      "   child: Column(\n"
      "      children: [\n"
      "         Text('Hello!'),\n"
      "         Text('Goodbye!')])))";

  final String explanation =
      "The screen forces the Scaffold to be exactly the same size of the screen."
      "\n\n"
      "So the Scaffold fills the screen."
      "\n\n"
      "The Scaffold tells the Container it can be any size it wants, but not bigger than the screen."
      "\n\n"
      "Note: When a widget tells its child it can be smaller than a certain size, "
      "we say the widget supplies \"loose\" constraints to its child. More on that later.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: blue,
        child: Column(
          children: [
            Text('Hello!'),
            Text('Goodbye!'),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example29 extends Example {
  final String code = "Scaffold(\n"
      "   body: Container(color: blue,\n"
      "   child: SizedBox.expand(\n"
      "      child: Column(\n"
      "         children: [\n"
      "            Text('Hello!'),\n"
      "            Text('Goodbye!')]))))";

  final String explanation =
      "If we want the Scaffold's child to be exactly the same size as the Scaffold itself, "
      "we can wrap its child into a SizedBox.expand."
      "\n\n"
      "Note: When a widget tells its child it must be of a certain size, "
      "we say the widget supplies \"tight\" constraints to its child. More on that later.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: blue,
          child: Column(
            children: [
              Text('Hello!'),
              Text('Goodbye!'),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
