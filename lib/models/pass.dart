class Pass {
  Pass(
      {this.id = 0,
      required this.title,
      required this.pass,
      this.description = ''});

  final int id;
  String title;
  String pass;
  String description;
}
