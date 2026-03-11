import 'package:flutter/material.dart';
import 'package:ar_chemistry_lab/models/experiment_model.dart';
import 'package:ar_chemistry_lab/services/experiment_service.dart';
import 'package:ar_chemistry_lab/screens/ar_experiment_screen.dart';

class ExperimentLibraryScreen extends StatefulWidget {
  const ExperimentLibraryScreen({super.key});

  @override
  State<ExperimentLibraryScreen> createState() => _ExperimentLibraryScreenState();
}

class _ExperimentLibraryScreenState extends State<ExperimentLibraryScreen> {
  late Future<List<Experiment>> _experimentsFuture;
  String _filterDifficulty = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _experimentsFuture = ExperimentService().loadExperiments();
  }

  List<Experiment> _filterExperiments(List<Experiment> experiments) {
    return experiments.where((exp) {
      final matchesSearch = exp.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          exp.objective.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesDifficulty =
          _filterDifficulty == 'All' || exp.difficultyLevel.toString() == _filterDifficulty;
      return matchesSearch && matchesDifficulty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment Library'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Experiment>>(
        future: _experimentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }

          final experiments = snapshot.data ?? [];
          final filteredExperiments = _filterExperiments(experiments);

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search experiments...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),

              // Filter Difficulty
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    'All',
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                  ]
                      .map((difficulty) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(difficulty == 'All' ? 'All' : '⭐ $difficulty'),
                              selected: _filterDifficulty == difficulty,
                              onSelected: (selected) {
                                setState(() {
                                  _filterDifficulty = difficulty;
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Experiments Grid
              Expanded(
                child: filteredExperiments.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No experiments found',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredExperiments.length,
                        itemBuilder: (context, index) {
                          final experiment = filteredExperiments[index];
                          return _buildExperimentCard(context, experiment);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExperimentCard(BuildContext context, Experiment experiment) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ARExperimentScreen(experiment: experiment),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.8),
              Colors.blue.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    experiment.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Objective
                  Text(
                    experiment.objective,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                    ),
                  ),
                  const Spacer(),

                  // Difficulty and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (idx) => Icon(
                            Icons.star,
                            size: 12,
                            color: idx < experiment.difficultyLevel
                                ? Colors.amber
                                : Colors.white30,
                          ),
                        ),
                      ),
                      Text(
                        '${experiment.estimatedTime}m',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Completion Badge
            if (experiment.isCompleted)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}