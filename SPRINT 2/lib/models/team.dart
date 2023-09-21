class Team {
  final int id;
  final String fullName; // eg. LAL
  final String abbreviation; // eg. LAL
  final String city; // eg. Los Angeles
  final String division; // eg. Los Angeles
  final String conference; // eg. Los Angeles

  Team(
      {required this.id,
      required this.fullName,
      required this.abbreviation,
      required this.city,
      required this.division,
      required this.conference});
}
