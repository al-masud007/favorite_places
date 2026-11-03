import 'package:uuid/uuid.dart';

class Place {
  static final uuid = Uuid();

  Place({required this.title}) : id = const Uuid().v4();

  final String id;
  final String title;
}
