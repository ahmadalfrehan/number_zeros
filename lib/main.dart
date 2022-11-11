import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_zeros_game/controller-game/controllerGame.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color = Colors.black;
  final double height = 60.0;
  final double width = 60.0;
  final controller = Get.put(ControllerGame());

  @override
  Widget build(BuildContext context) {
    var showDraggable = color == Colors.black;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const MyHomePage();
              }), (route) => false);
            },
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: _buildGameBody(),
    );
  }

  //
  // List<List<String>> gridState = [
  //   ['', '‘T’', '', '', '', '', '', '‘P2’'],
  //   ['', '', '', '‘T’', '', '', '', ''],
  //   ['‘B’', '‘T’', '', '', '', '‘B’', '', ''],
  //   ['', '', '', '‘B’', '', '', '', '‘T’'],
  //   ['', '', '‘T’', '', '', '‘T’', '', ''],
  //   ['', '', '', '', '', '', '', '‘B’'],
  //   ['', '', '', '', '‘T’', '', '', ''],
  //   ['‘P1’', '', '', '', '', '', '‘T’', ''],
  // ];
  // var gridState = List.generate(
  //     3, (i) => List.generate(3, (j) => i.toString() + j.toString()));

  Widget _buildGameBody() {
    int gridStateLength = controller.twoDList.length;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridStateLength,
                ),
                itemBuilder: _buildGridItems,
                itemCount: gridStateLength * gridStateLength,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _textField(context, controller.focus1, next: controller.focus2),
              _textField(context, controller.focus2, next: controller.focus3),
              _textField(context, controller.focus3, next: controller.focus4),
              _textField(context, controller.focus4, next: controller.focus5),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                controller.move(controller.x1!, controller.y1!, controller.x2!,
                    controller.y2!);
                // controller.move(0, 1, 1, 1);
                // controller.move(1, 0, 1, 1);
                // controller.move(1, 2, 1, 1);
                // controller.move(1, 1, 2, 1);
                controller.isThePlayerWin();
                if (controller.isThePlayerWin()==true) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(
                  //     content: Text('you Win'),
                  //   ),
                  // );
                }
              });
            },
            child: const Text('move'),
          )
        ],
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = controller.twoDList.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () => _buildGridItem(x, y),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Center(
            child: _buildGridItem(x, y),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {
    return Text(controller.twoDList[x][y]);
    //   case '':
    //     return Text('');
    //     break;    case 'P1':
    //   return Container(
    //     color: Colors.blue,
    //   );
    //   break;    case 'P2':
    //   return Container(
    //     color: Colors.yellow,
    //   );
    //   break;    case 'T':
    //   return Icon(
    //     Icons.terrain,
    //     size: 40.0,
    //     color: Colors.red,
    //   );
    //   break;    case 'B':
    //   return Icon(Icons.remove_red_eye, size: 40.0);
    //   break;    default:
    //   return Text(gridState[x][y].toString());
    // }
  }

/* Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DragTarget<int>(
                  onAccept: (data) => setState(() {
                        if (controller.firstNumber.value == data) {
                        } else {}
                      }),
                  builder: (context, _, __) {
                    return _dragAble(controller.firstNumber.value.toInt());
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DragTarget<int>(
                    onAccept: (data) => setState(() {}),
                    builder: (context, _, __) =>
                        _dragAble(controller.firstNumber.value.toInt()),
                  ),
                  DragTarget<int>(
                    onAccept: (data) => setState(() {}),
                    builder: (context, _, __) =>
                        _dragAble(controller.thirdNumber.value.toInt()),
                  ),
                  DragTarget<int>(
                    onAccept: (data) => setState(() {}),
                    builder: (context, _, __) =>
                        _dragAble(controller.firstNumber.value.toInt()),
                  ),
                ],
              ),
              IgnorePointer(
                ignoring: !showDraggable,
                child: DragTarget<int>(
                  onAccept: (data) => setState(() {
                    if (controller.fourthNumber.value == data) {
                      showDraggable = !showDraggable;
                      color = Colors.white;
                    }
                  }),
                  builder: (context, _, __) {
                    return _dragAble(controller.fifthNumber.value);
                  },
                ),
              ),
            ],
          ),
        ),*/
  _dragAble(var number) {
    return Draggable<int>(
      data: number,
      onDragCompleted: () {},
      childWhenDragging: Container(
        color: Colors.red,
        height: height,
        width: width,
      ),
      feedback: Container(
        color: Colors.green,
        height: height,
        width: width,
      ),
      child: Container(
        color: Colors.orange,
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Text(number == 0 ? '' : '$number'),
      ),
    );
  }

  _textField(BuildContext context, focus, {next}) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        maxLength: 1,
        onChanged: (value) {
          if (focus == controller.focus1) {
            controller.x1 = int.parse(value);
          } else if (focus == controller.focus2) {
            controller.y1 = int.parse(value);
          } else if (focus == controller.focus3) {
            controller.x2 = int.parse(value);
          } else if (focus == controller.focus4) {
            controller.y2 = int.parse(value);
          }
          if (next != null) {
            FocusScope.of(context).requestFocus(next);
          }
        },
        textAlign: TextAlign.center,
        focusNode: focus,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.blue,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
