import '../utils/index.dart';

class Day01 extends GenericDay {
  Day01() : super(1);

  @override
  Iterable<int> parseInput() {
    final inputUtil = InputUtil(day);
    final input = inputUtil.getPerLine();
    final inputByElves = <List<String>>[];
    var tmpElveInput = <String>[];
    for (final line in input) {
      if (line.isNotEmpty) {
        tmpElveInput.add(line);
      } else {
        inputByElves.add(tmpElveInput);
        tmpElveInput = [];
      }
    }

    // We convert each string to int then we sum them up.
    final sumInputByElves = inputByElves
        .map((e) => e.map((e) => int.parse(e)))
        .map((e) => e.reduce((a, b) => a + b));

    return sumInputByElves;
  }

  @override
  int solvePart1() {
    final sumByElves = parseInput();
    final maxCalories = sumByElves.reduce((a, b) => a > b ? a : b);

    return maxCalories;
  }

  @override
  int solvePart2() {
    final sumByElves = parseInput();
    final sortedSumByElves = sumByElves.toList()
      ..sort((a, b) => b.compareTo(a));

    final topThreeElves = sortedSumByElves.take(3);
    final sumTopThreeElves = topThreeElves.reduce((a, b) => a + b);
    return sumTopThreeElves;
  }
}
