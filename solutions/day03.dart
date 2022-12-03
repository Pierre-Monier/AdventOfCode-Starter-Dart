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
    return _itemsValue[communItem]!;
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
    return _itemsValue[badgeItem.first]!;
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

const _itemsValue = {
  'a': 1,
  'b': 2,
  'c': 3,
  'd': 4,
  'e': 5,
  'f': 6,
  'g': 7,
  'h': 8,
  'i': 9,
  'j': 10,
  'k': 11,
  'l': 12,
  'm': 13,
  'n': 14,
  'o': 15,
  'p': 16,
  'q': 17,
  'r': 18,
  's': 19,
  't': 20,
  'u': 21,
  'v': 22,
  'w': 23,
  'x': 24,
  'y': 25,
  'z': 26,
  'A': 27,
  'B': 28,
  'C': 29,
  'D': 30,
  'E': 31,
  'F': 32,
  'G': 33,
  'H': 34,
  'I': 35,
  'J': 36,
  'K': 37,
  'L': 38,
  'M': 39,
  'N': 40,
  'O': 41,
  'P': 42,
  'Q': 43,
  'R': 44,
  'S': 45,
  'T': 46,
  'U': 47,
  'V': 48,
  'W': 49,
  'X': 50,
  'Y': 51,
  'Z': 52,
};
