class PlayerWithStats {
  final String fullName;
  final String team;
  final int gamesPlayed;
  final double points;
  final double assists;
  final double rebounds;

  PlayerWithStats({
    required this.fullName,
    required this.team,
    required this.gamesPlayed,
    required this.points,
    required this.assists,
    required this.rebounds,
  });

  // Custom method to compare players based on points, assists, or rebounds
  bool isBetterThan(PlayerWithStats otherPlayer, String statToCompare) {
    switch (statToCompare) {
      case 'points':
        return this.points > otherPlayer.points;
      case 'assists':
        return this.assists > otherPlayer.assists;
      case 'rebounds':
        return this.rebounds > otherPlayer.rebounds;
      default:
        return false; // Handle other cases as needed
    }
  }
}
