import '../utils/index.dart';

class FileEntity {
  final String name;

  FileEntity(
    this.name,
  );
}

class File extends FileEntity {
  final int size;

  File(super.name, this.size);

  factory File.fromData(String data) {
    final rawData = data.split(' ');
    final name = rawData.last;
    final size = int.parse(rawData.first);
    return File(name, size);
  }

  @override
  String toString() {
    return 'File{name: $name, size: $size}';
  }
}

class Dir extends FileEntity {
  final List<FileEntity> files;
  final Dir? parent;

  Dir(super.name, this.files, this.parent);

  factory Dir.root() {
    return Dir('/', [], null);
  }

  factory Dir.fromData(String data, Dir? parent) {
    final name = data.split(' ').last;
    return Dir(name, [], parent);
  }

  void addFile(FileEntity file) {
    files.add(file);
  }

  Dir getDirWithName(String dirName) {
    return files.firstWhere((e) => e.name == dirName) as Dir;
  }

  @override
  String toString() {
    return 'Dir{name: $name, files: $files}';
  }

  int getSize() {
    return files.fold<int>(0, (previousValue, element) {
      if (element is File) {
        return previousValue + element.size;
      } else {
        return previousValue + (element as Dir).getSize();
      }
    });
  }

  List<Dir> get nestedDir {
    final nestedDir = <Dir>[];

    for (final file in files) {
      if (file is Dir) {
        nestedDir.add(file);
        nestedDir.addAll(file.nestedDir);
      }
    }

    return nestedDir;
  }
}

class FileSystem {
  Dir location;

  FileSystem(this.location);

  static const _parentDir = '..';
  static const _availableSpace = 70000000;

  void setLocation(String dirName) {
    if (dirName == _parentDir) {
      location = location.parent!;
    } else {
      location = location.getDirWithName(dirName);
    }
  }

  void printLocation() {
    print('currentLocation: ${location.name}');
    for (final entity in location.files) {
      print(entity.toString());
    }
  }

  void _goToRoot() {
    while (location.parent != null) {
      location = location.parent!;
    }
  }

  int getSmallDirSize(int bigDirSize) {
    _goToRoot();
    final everyDir = location.nestedDir;
    return everyDir.map((e) => e.getSize()).where((e) => e < bigDirSize).sum;
  }

  int getCloserDirSize(int minAvailableSpace) {
    _goToRoot();
    final everyDir = location.nestedDir;
    final usedSpace = location.getSize();
    final currentAvailableSpace = _availableSpace - usedSpace;
    final desiredSize = minAvailableSpace - currentAvailableSpace;

    return everyDir
        .map((e) => e.getSize())
        .where((e) => e > desiredSize)
        .sorted((a, b) => a.compareTo(b))
        .first;
  }
}

class Day07 extends GenericDay {
  Day07() : super(7);

  @override
  parseInput() {
    final data = input.getPerLine();
    return data.skip(1).fold<FileSystem>(FileSystem(Dir.root()),
        (fileSystem, e) {
      if (e.isACDCmd) {
        final dirName = e.split(' ').last;
        fileSystem.setLocation(dirName);
      } else if (e.isAFileEntity) {
        final fileEntity =
            e.isADir ? Dir.fromData(e, fileSystem.location) : File.fromData(e);
        fileSystem.location.addFile(fileEntity);
      }

      return fileSystem;
    });
  }

  @override
  int solvePart1() {
    final fileSystem = parseInput();
    return fileSystem.getSmallDirSize(100000);
  }

  @override
  int solvePart2() {
    final fileSystem = parseInput();
    return fileSystem.getCloserDirSize(30000000);
  }
}

extension on String {
  bool get isAFileEntity {
    return !startsWith('\$');
  }

  bool get isACDCmd {
    return startsWith('\$') && split(' ')[1] == 'cd';
  }

  bool get isADir {
    return startsWith('dir');
  }
}
