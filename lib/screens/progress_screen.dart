import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';
import 'package:ar_chemistry_lab/utils/colors.dart';
import 'package:ar_chemistry_lab/utils/constants.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracker'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Consumer<AppState>(
          builder: (context, appState, _) {
            return Column(
              children: [
                // Score card
                Container(
                  margin: const EdgeInsets.all(AppConstants.spacingLarge),
                  padding: const EdgeInsets.all(AppConstants.spacingLarge),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryGradient,
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadiusLarge,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Total Score',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: AppConstants.fontSizeMedium,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingMedium),
                      Text(
                        appState.score.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppConstants.fontSizeHeading,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingLarge,
                  ),
                  child: Row(
                    children: [
                      _buildStatCard(
                        'Experiments',
                        appState.completedExperiments.length.toString(),
                        Icons.science,
                      ),
                      const SizedBox(width: AppConstants.spacingMedium),
                      _buildStatCard(
                        'Level',
                        _getLevel(appState.score).toString(),
                        Icons.trending_up,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.spacingLarge),

                // Achievements section
                Padding(
                  padding: const EdgeInsets.all(AppConstants.spacingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Achievements',
                        style: TextStyle(
                          fontSize: AppConstants.fontSizeXLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingMedium),
                      _buildAchievementItem(
                        'First Experiment',
                        appState.completedExperiments.isNotEmpty,
                        Icons.star,
                      ),
                      _buildAchievementItem(
                        'Experiment Master',
                        appState.completedExperiments.length >= 10,
                        Icons.stars,
                      ),
                      _buildAchievementItem(
                        'Score 500',
                        appState.score >= 500,
                        Icons.whatshot,
                      ),
                      _buildAchievementItem(
                        'Score 1000',
                        appState.score >= 1000,
                        Icons.bolt,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: AppConstants.iconSizeLarge, color: AppColors.primary),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              value,
              style: const TextStyle(
                fontSize: AppConstants.fontSizeXLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppConstants.fontSizeSmall,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(String title, bool unlocked, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        decoration: BoxDecoration(
          color: unlocked ? AppColors.success.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          border: Border.all(
            color: unlocked ? AppColors.success : Colors.grey,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppConstants.iconSizeLarge,
              color: unlocked ? AppColors.success : Colors.grey,
            ),
            const SizedBox(width: AppConstants.spacingMedium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: unlocked ? AppColors.text : Colors.grey,
                  ),
                ),
                Text(
                  unlocked ? 'Unlocked' : 'Locked',
                  style: TextStyle(
                    fontSize: AppConstants.fontSizeSmall,
                    color: unlocked ? AppColors.success : Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              unlocked ? Icons.check_circle : Icons.lock,
              color: unlocked ? AppColors.success : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  int _getLevel(int score) {
    if (score < 100) return 1;
    if (score < 300) return 2;
    if (score < 600) return 3;
    if (score < 1000) return 4;
    return 5;
  }
}
