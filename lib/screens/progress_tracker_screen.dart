import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';

class ProgressTrackerScreen extends StatelessWidget {
  const ProgressTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final stats = appState.getUserStats();
          final totalScore = stats['totalScore'] as int;
          final experimentsCompleted = stats['experimentsCompleted'] as int;
          final quizzesCompleted = stats['quizzesCompleted'] as int;
          final averageScore = stats['averageQuizScore'] as int;
          final progress = (experimentsCompleted / 100 * 100).clamp(0, 100).toInt();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overall Stats Card
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Score',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$totalScore',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatItem(
                            label: 'Experiments',
                            value: '$experimentsCompleted/100',
                          ),
                          _StatItem(
                            label: 'Quizzes Done',
                            value: quizzesCompleted.toString(),
                          ),
                          _StatItem(
                            label: 'Avg Score',
                            value: '$averageScore%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Progress Bar
                Text(
                  'Experiment Progress',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 12,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation(Colors.green.shade600),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$progress% Complete ($experimentsCompleted/100)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Skills Mastery
                Text(
                  'Skills Mastery',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ..._buildSkillRows(context),
                const SizedBox(height: 24),

                // Achievements
                Text(
                  'Achievements',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _AchievementBadge(
                      icon: Icons.school,
                      label: 'Scholar',
                      unlocked: experimentsCompleted >= 10,
                    ),
                    _AchievementBadge(
                      icon: Icons.flash_on,
                      label: 'Fast Learner',
                      unlocked: averageScore >= 80,
                    ),
                    _AchievementBadge(
                      icon: Icons.star,
                      label: 'Perfect Score',
                      unlocked: averageScore == 100,
                    ),
                    _AchievementBadge(
                      icon: Icons.science,
                      label: 'Scientist',
                      unlocked: experimentsCompleted >= 25,
                    ),
                    _AchievementBadge(
                      icon: Icons.emoji_events,
                      label: 'Champion',
                      unlocked: totalScore >= 1000,
                    ),
                    _AchievementBadge(
                      icon: Icons.trending_up,
                      label: 'Rising Star',
                      unlocked: experimentsCompleted >= 50,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildSkillRows(BuildContext context) {
    final skills = [
      {'name': 'Acid-Base Reactions', 'level': 3},
      {'name': 'Precipitation', 'level': 2},
      {'name': 'Combustion', 'level': 4},
      {'name': 'Gas Evolution', 'level': 2},
    ];

    return skills
        .map((skill) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        skill['name'] as String,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Level ${skill['level']}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (skill['level'] as int) / 5,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(Colors.orange[400]),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool unlocked;

  const _AchievementBadge({
    required this.icon,
    required this.label,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: unlocked ? Colors.amber[100] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked ? Colors.amber : Colors.grey[400]!,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: unlocked ? Colors.amber[700] : Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: unlocked ? Colors.amber[900] : Colors.grey[600],
            ),
          ),
          if (!unlocked)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Locked',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
