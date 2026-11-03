class Place {
  Place({required this.title}) : id = const Uuid().v4();

  final String id;
  final String title;
}
