import 'dart:collection';

import 'package:number_zeros_game/controller-game/controllerGame.dart';

//import 'package:flutter/cupertino.dart';
class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  // E pop() => _list.removeLast();

  // E get peek => _list.last;
  E? pop() => (isEmpty) ? null : _list.removeLast();

  void addAll(Iterable<E> value) => _list.addAll(value);

  E? get peek => (isEmpty) ? null : _list.last;

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

class H {
  int c = 0;

  ControllerGame dfsGame() {
    Set<ControllerGame> visited = HashSet();
    Stack st = Stack();
    st.push(this);
    ControllerGame a = ControllerGame();
    while (st.isNotEmpty) {
      if (!visited.contains(st.peek())) {
        c++;
        ControllerGame a = ControllerGame();
        //  Game a = st.pop();
        // st.addAll(a.getNextState());
        if (a.finaly()) {
          return a;
        }
      } else {
        c++;
        st.pop();
      }
    }
    return a;
  }

  ControllerGame bfsGame() {
    Set<ControllerGame> visited = HashSet();
    Queue qs = Queue();
    qs.add(this);
    ControllerGame a = ControllerGame();
    while (qs.isNotEmpty) {
      if (qs.last) {
        return qs.last; //[qs.length-1]
      }
      if (!visited.contains(qs.last)) {
        c++;
        visited.add(qs.last);
        //Game a = qs.poll();
        //qs.addAll(a.getNextState());
      } else {
        c++;
        //qs.poll();
      }
    }
    //  System.out.println("not found");
    return a;
  }

  ControllerGame ucsGame() {
    Set visited = Set();
    Queue st = Queue();
    st.add(this);
    visited.add(this);
    ControllerGame a = ControllerGame();
    while (st.isNotEmpty) {
      c++;
      //  Game a = st.poll();
      //Set<Game> ls = a.getNextState();
      // for (Game g : ls) {
      //   if (g.finaly()) {
      //     return g;
      // //   }
      //   if (!visited.contains(g)) {
      //     visited.add(g);
      //     st.add(g);
      //   }
    }
    //System.out.println("not found");
    return a;
  }

  ControllerGame hcGame() {
    Set visited = HashSet();
    Queue qs = Queue();
    qs.add(this);
    ControllerGame a = ControllerGame();
    while (!qs.isNotEmpty) {
      c++;
      if (qs.last) {
        return qs.last;
      }
      if (!visited.contains(qs.last)) {
        visited.add(qs.last);
        //ControllerGame a = qs.poll();
        //qs.addAll(a.getNextState());
      } else {
        //qs.poll();
      }
    }
    //System.out.println("not found");
    return a;
  }

  ControllerGame AStarGame() {
    Set visited = HashSet();
    Queue qs = Queue();
    qs.add(this);
    ControllerGame a = ControllerGame();
    while (qs.isNotEmpty) {
      c++;
      if (qs.last) {
        return qs.last;
      }
      if (!visited.contains(qs.last)) {
        visited.add(qs.last);
        //ControllerGame a = qs.poll();
        // qs.addAll(a.getNextState());
      } else {
        // qs.poll();
      }
    }
    //System.out.println("not found");
    return a;
  }
}
