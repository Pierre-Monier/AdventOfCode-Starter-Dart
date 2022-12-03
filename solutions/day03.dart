import '../utils/index.dart';

class Rucksack {
  final String compartment1;
  final String compartment2;

  factory Rucksack.fromData(String data) {
    final compartment1 = data.substring(0, data.length ~/ 2);
    final compartment2 = data.substring(data.length ~/ 2);
    return Rucksack(compartment1, compartment2);
  }

  Rucksack(this.compartment1, this.compartment2);

  List<String> get allItems =>
      [...compartment1.split(''), ...compartment2.split('')].toList();

  int getCommunItemPriority() {
    final items1 = compartment1.split('').toSet();
    final items2 = compartment2.split('').toSet();
    final communItem = items1.intersection(items2).first;
    return getItemValue(communItem);
  }
}

class ElfGroup {
  final List<Rucksack> rucksacks;

  factory ElfGroup.fromData(List<String> data) {
    if (data.length != 3) {
      throw Exception('ElfGroup must have 3 rucksacks');
    }

    final rucksacks = data.map((e) => Rucksack.fromData(e)).toList();
    return ElfGroup(rucksacks);
  }

  ElfGroup(this.rucksacks);

  int badgePriority() {
    final badgeItem = rucksacks.fold<Set<String>>(
        rucksacks.first.allItems.toSet(),
        (a, b) => a.intersection(b.allItems.toSet()));
    return getItemValue(badgeItem.first);
  }
}

class Day03 extends GenericDay {
  Day03() : super(3);

  @override
  List<String> parseInput() {
    return input.getPerLine();
  }

  @override
  int solvePart1() {
    final rucksacksData = parseInput();
    final rucksacks = rucksacksData.map((e) => Rucksack.fromData(e)).toList();

    final duplicateItemsPriorities = rucksacks
        .map(
          (e) => e.getCommunItemPriority(),
        )
        .sum;
    return duplicateItemsPriorities;
  }

  @override
  int solvePart2() {
    final rucksacksData = parseInput();
    final elfGroupsData = partition(rucksacksData, 3);

    final elfGroups = elfGroupsData.map((e) => ElfGroup.fromData(e)).toList();
    final badgePriorities = elfGroups.map((e) => e.badgePriority()).sum;
    return badgePriorities;
  }
}

// stole this from https://github.com/darrenaustin/advent-of-code-dart/blob/main/lib/src/2022/day03.dart
int getItemValue(String s) {
  final int lowerA = 'a'.codeUnitAt(0);
  final int upperA = 'A'.codeUnitAt(0);

  if (s.contains(RegExp(r'[a-z]'))) {
    return s.codeUnitAt(0) - lowerA + 1;
  }

  return s.codeUnitAt(0) - upperA + 27;
}
