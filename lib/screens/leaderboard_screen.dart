import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final leaderboard = appState.getLeaderboard();
          final userScore = appState.score;
          final userRank = leaderboard.indexWhere((entry) => entry['experimentId'] == 'You') + 1;

          return Column(
            children: [
              // User Stats Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Rank',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '#$userRank',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total Score',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$userScore',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade600,
                        ),
                        onPressed: () {},
                        child: const Text('Share Score'),
                      ),
                    ),
                  ],
                ),
              ),

              // Leaderboard Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.amber[700]),
                    const SizedBox(width: 8),
                    Text(
                      'Top Performers',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Leaderboard List
              Expanded(
                child: leaderboard.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.leaderboard,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No scores yet',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: leaderboard.length,
                        itemBuilder: (context, index) {
                          final entry = leaderboard[index];
                          final rank = index + 1;
                          final score = entry['score'] ?? 0;
                          final name = entry['experimentId'] ?? 'Unknown';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: rank <= 3
                                      ? [
                                          _getRankColor(rank).withOpacity(0.2),
                                          _getRankColor(rank).withOpacity(0.05),
                                        ]
                                      : [Colors.grey[100]!, Colors.grey[50]!],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: rank <= 3
                                      ? _getRankColor(rank).withOpacity(0.5)
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    // Rank Badge
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _getRankColor(rank),
                                        boxShadow: rank <= 3
                                            ? [
                                                BoxShadow(
                                                  color: _getRankColor(rank).withOpacity(0.4),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Center(
                                        child: rank <= 3
                                            ? Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 24,
                                              )
                                            : Text(
                                                '#$rank',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Name and Rank
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            rank == 1 ? '🥇 1st Place' : rank == 2 ? '🥈 2nd Place' : rank == 3 ? '🥉 3rd Place' : 'Top Performer',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: const Color(0xFFFF6600),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Score
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '$score',
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber[700],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'points',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[600] ?? Colors.grey;
      case 3:
        return Colors.orange[800] ?? Colors.orange;
      default:
        return Colors.blue;
    }
  }
}