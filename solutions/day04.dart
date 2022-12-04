import '../utils/index.dart';

class Day04 extends GenericDay {
  Day04() : super(4);

  @override
  Iterable<Tuple2<Tuple2<int, int>, Tuple2<int, int>>> parseInput() {
    return input.getPerLine().map(getSectionRanges);
  }

  Tuple2<Tuple2<int, int>, Tuple2<int, int>> getSectionRanges(String data) {
    final sections = data.split(',');
    final firstSectionMinAndMax = sections.first.split('-');
    final firstMin = int.parse(firstSectionMinAndMax.first);
    final firstMax = int.parse(firstSectionMinAndMax.last);

    final secondSectionMinAndMax = sections.last.split('-');
    final secondMin = int.parse(secondSectionMinAndMax.first);
    final secondMax = int.parse(secondSectionMinAndMax.last);

    return Tuple2(
      Tuple2(firstMin, firstMax),
      Tuple2(secondMin, secondMax),
    );
  }

  bool isRangesFullyContained(
      Tuple2<Tuple2<int, int>, Tuple2<int, int>> ranges) {
    final firstRange = ranges.item1;
    final secondRange = ranges.item2;

    return firstRange.item1 <= secondRange.item1 &&
            firstRange.item2 >= secondRange.item2 ||
        secondRange.item1 <= firstRange.item1 &&
            secondRange.item2 >= firstRange.item2;
  }

  bool isPartiallyContained(Tuple2<Tuple2<int, int>, Tuple2<int, int>> ranges) {
    final firstRange = ranges.item1;
    final firstSections = List.generate(firstRange.item2 - firstRange.item1 + 1,
        (index) => index + firstRange.item1).toSet();
    final secondRange = ranges.item2;
    final secondSections = List.generate(
        secondRange.item2 - secondRange.item1 + 1,
        (index) => index + secondRange.item1).toSet();

    return firstSections.intersection(secondSections).isNotEmpty;
  }

  @override
  int solvePart1() {
    return parseInput().where(isRangesFullyContained).length;
  }

  @override
  int solvePart2() {
    return parseInput().where(isPartiallyContained).length;
  }
}
