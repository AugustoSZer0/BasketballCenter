import 'package:flutter/material.dart';
import '../models/playerWithStats.dart';

class PlayerDetailPage extends StatelessWidget {
  final PlayerWithStats player;

  PlayerDetailPage({required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Aumenta o padding externo
      child: Container(
        padding: const EdgeInsets.all(20.0), // Aumenta o padding interno
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
              BorderRadius.circular(12), // Aumenta o raio do borderRadius
        ),
        child: Column(
          // Substitui o ListTile por um Column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player.fullName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('Time: ${player.team}', style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('Partidas Jogadas: ${player.gamesPlayed}',
                style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('Pontos: ${player.points}',
                style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('Assistências: ${player.assists}',
                style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('Rebotes: ${player.rebounds}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
