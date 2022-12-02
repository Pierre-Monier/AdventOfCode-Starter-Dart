import '../utils/index.dart';

enum Result {
  win(6),
  lose(0),
  draw(3);

  final int value;
  const Result(this.value);

  static Result desiredResult(String s) => {
        'X': Result.lose,
        'Y': Result.draw,
        'Z': Result.win,
      }[s]!;
}

enum Shape {
  rock(1),
  paper(2),
  scissors(3);

  final int value;
  const Shape(this.value);

  static Shape shapeFor(String s) => {
        'A': Shape.rock,
        'B': Shape.paper,
        'C': Shape.scissors,
        'X': Shape.rock,
        'Y': Shape.paper,
        'Z': Shape.scissors,
      }[s]!;

  Shape get beats => {
        Shape.rock: Shape.scissors,
        Shape.paper: Shape.rock,
        Shape.scissors: Shape.paper,
      }[this]!;

  Shape get losesTo => {
        Shape.rock: Shape.paper,
        Shape.paper: Shape.scissors,
        Shape.scissors: Shape.rock,
      }[this]!;
}

class Match {
  final Shape opponent;
  final Shape you;

  Match(this.opponent, this.you);

  factory Match.fromPart1(List<String> data) {
    final Shape opponent = Shape.shapeFor(data.first);
    final Shape you = Shape.shapeFor(data.last);

    return Match(opponent, you);
  }

  factory Match.fromPart2(List<String> data) {
    final Shape opponent = Shape.shapeFor(data.first);
    final Shape you = _getPlayerFor(opponent, Result.desiredResult(data.last));

    return Match(opponent, you);
  }

  static Shape _getPlayerFor(Shape opponent, Result result) {
    switch (result) {
      case Result.win:
        return opponent.losesTo;
      case Result.lose:
        return opponent.beats;
      case Result.draw:
        return opponent;
    }
  }

  Result get result {
    if (opponent == you) {
      return Result.draw;
    } else if (opponent.beats == you) {
      return Result.lose;
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
    final shapePoints = matchs.map((e) => e.you.value).sum;
    return resultPoints + shapePoints;
  }
}
