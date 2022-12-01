import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  List<int> parseInput() {
    final inputData = input.getPerLine();

    final caloriesByElves = <int>[];
    var tmpColories = 0;

    for (final line in inputData) {
      if (line.isNotEmpty) {
        tmpColories += int.parse(line);
      } else {
        caloriesByElves.add(tmpColories);
        tmpColories = 0;
      }
    }

    return caloriesByElves;
  }

  @override
  int solvePart1() {
    final caloriesByElves = parseInput();
    final maxCalories = caloriesByElves.max;

    return maxCalories;
  }

  @override
  int solvePart2() {
    final sumByElves = parseInput();
    final topThreeElves = sumByElves.toList()
      ..sort((a, b) => b.compareTo(a))
      ..take(3);

    return topThreeElves.sum;
  }
}
