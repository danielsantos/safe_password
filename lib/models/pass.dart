class Pass {
  Pass(
      {this.id = 0,
      required this.title,
      required this.pass,
      this.description = ''});

  final int id;
  final String title;
  final String pass;
  final String description;
}
