import '../utils/index.dart';

class Day06 extends GenericDay {
  Day06() : super(6);

  @override
  String parseInput() {
    return input.getPerLine().first;
  }

  int countNonDuplicatePattern(String input, int size) {
    final charaters = input.split('');

    var count = 0;
    var current = <String>[];

    while (current.length < size) {
      final char = charaters[count];
      if (current.contains(char)) {
        final duplicateIndex = current.indexOf(char);
        current.removeRange(0, duplicateIndex + 1);
        current = [...current, char];
      } else {
        current.add(char);
      }

      count++;
    }

    return count;
  }

  @override
  int solvePart1() {
    return countNonDuplicatePattern(parseInput(), 4);
  }

  @override
  int solvePart2() {
    return countNonDuplicatePattern(parseInput(), 14);
  }
}
