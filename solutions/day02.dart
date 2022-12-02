import '../utils/index.dart';

enum Result {
  win(6),
  loose(0),
  draw(3);

  final int value;
  const Result(this.value);
}

enum Shape {
  rock(1),
  paper(2),
  scissors(3);

  final int value;
  const Shape(this.value);
}

class Match {
  final Shape player1;
  final Shape player2;

  Match(this.player1, this.player2);

  factory Match.fromPart1(List<String> data) {
    late final Shape player1;
    late final Shape player2;

    final player1Data = data.first;
    final player2Data = data.last;

    if (player1Data == 'A') {
      player1 = Shape.rock;
    } else if (player1Data == 'B') {
      player1 = Shape.paper;
    } else {
      player1 = Shape.scissors;
    }

    if (player2Data == 'X') {
      player2 = Shape.rock;
    } else if (player2Data == 'Y') {
      player2 = Shape.paper;
    } else {
      player2 = Shape.scissors;
    }

    return Match(player1, player2);
  }

  factory Match.fromPart2(List<String> data) {
    late final Shape player1;
    late final Shape player2;

    final player1Data = data.first;
    final player2Data = data.last;

    if (player1Data == 'A') {
      player1 = Shape.rock;
    } else if (player1Data == 'B') {
      player1 = Shape.paper;
    } else {
      player1 = Shape.scissors;
    }

    if (player2Data == 'X') {
      // get the Shape to loose against player1
      player2 = player1 == Shape.rock
          ? Shape.scissors
          : player1 == Shape.paper
              ? Shape.rock
              : Shape.paper;
    } else if (player2Data == 'Y') {
      player2 = player1;
    } else {
      // get the Shape to win against player1
      player2 = player1 == Shape.rock
          ? Shape.paper
          : player1 == Shape.paper
              ? Shape.scissors
              : Shape.rock;
    }

    return Match(player1, player2);
  }

  Result get result {
    if (player1 == player2) {
      return Result.draw;
    }

    if (player1 == Shape.rock && player2 == Shape.scissors ||
        player1 == Shape.paper && player2 == Shape.rock ||
        player1 == Shape.scissors && player2 == Shape.paper) {
      return Result.loose;
    }

    return Result.win;
  }
}

class Day02 extends GenericDay {
  Day02() : super(2);

  @override
  List<List<String>> parseInput() {
    final strategy = input.getPerLine();
    final matchs = strategy.map((s) => s.split(' '));
    return matchs.toList();
  }

  @override
  int solvePart1() {
    final matchData = parseInput();
    final matchs = matchData.map((m) => Match.fromPart1(m));
    return getPoints(matchs);
  }

  @override
  int solvePart2() {
    final matchData = parseInput();
    final matchs = matchData.map((m) => Match.fromPart2(m));
    return getPoints(matchs);
  }

  int getPoints(Iterable<Match> matchs) {
    final resultPoints = matchs.map((e) => e.result.value).sum;
    final shapePoints = matchs.map((e) => e.player2.value).sum;
    return resultPoints + shapePoints;
  }
}
