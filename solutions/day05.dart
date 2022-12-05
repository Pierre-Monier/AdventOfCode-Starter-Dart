import '../utils/index.dart';
import 'dart:math' as math;

class Ship {
  final List<List<String>> stacks;
  final List<Tuple3<int, int, int>> moves;

  Ship(this.stacks, this.moves);

  void move() {
    for (final move in moves) {
      final quantity = move.item1;
      final from = move.item2 - 1;
      final to = move.item3 - 1;

      for (var i = 0; i < quantity; i++) {
        final crateToMove = stacks[from].removeLast();
        stacks[to].add(crateToMove);
      }
    }
  }

  void moveImproved() {
    for (final move in moves) {
      final quantity = move.item1;
      final from = move.item2 - 1;
      final to = move.item3 - 1;

      final cratesToMove = stacks[from].reversed.take(quantity).toList();
      stacks[to].addAll(cratesToMove.reversed);

      final startIndex = math.max(stacks[from].length - quantity, 0);
      stacks[from].removeRange(startIndex, stacks[from].length);
    }
  }

  String getTopCratesOfStacks() {
    return stacks.map((stack) => stack.lastOrNull).join();
  }
}

class Day05 extends GenericDay {
  Day05() : super(5);

  @override
  Ship parseInput() {
    final data = input.getPerLine();
    final separatorIndex = getSeparatorIndex(data);

    final stacksData = data.sublist(0, separatorIndex);
    final indexes = stacksData
        .removeLast()
        .split('')
        .mapIndexed((i, e) => e != ' ' ? i : null)
        .whereType<int>()
        .toList();

    final effectiveStackData = stacksData
        .map((e) => List.generate(indexes.length, (i) => e[indexes[i]]));

    final stacks = List<List<String>>.filled(indexes.length, []);

    for (var i = 0; i < stacks.length; i++) {
      stacks[i] = effectiveStackData.map((e) => e[i]).toList();
    }

    final orderedStacks = stacks
        .map((e) => e
            .where((e) => RegExp(r'[a-zA-Z]').hasMatch(e))
            .toList()
            .reversed
            .toList())
        .toList();

    final movesData = data.sublist(separatorIndex + 1);
    final moves = movesData
        .map((e) =>
            e.split(RegExp(r'[a-zA-Z\s]')).where((e) => e.isNotEmpty).toList())
        .map((e) {
      return Tuple3<int, int, int>(
          int.parse(e[0]), int.parse(e[1]), int.parse(e[2]));
    }).toList();

    return Ship(orderedStacks, moves);
  }

  int getSeparatorIndex(List<String> data) {
    return data.indexOf('');
  }

  @override
  int solvePart1() {
    final ship = parseInput();
    ship.move();
    return 0;
  }

  @override
  int solvePart2() {
    final ship = parseInput();
    ship.moveImproved();
    print(ship.getTopCratesOfStacks());
    return 0;
  }
}
