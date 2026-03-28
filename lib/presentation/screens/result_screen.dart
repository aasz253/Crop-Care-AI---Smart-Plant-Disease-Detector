import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/disease_info.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scanProvider = context.watch<ScanProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final locale = settingsProvider.locale;
    final result = scanProvider.currentResult;

    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Result')),
        body: const Center(child: Text('No result available')),
      );
    }

    final diseaseInfo = DiseaseDatabase.getDiseaseById(result.diseaseId);
    final isHealthy = result.diseaseId == 'healthy';
    final confidencePercent = (result.confidence * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'sw' ? 'Matokeo' : 'Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              final text = '${result.diseaseName}. $confidencePercent percent confidence. ${diseaseInfo?.getCause(locale) ?? ""}';
              settingsProvider.speak(text);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Container(
              height: 250,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: result.imagePath.isNotEmpty
                    ? Image.file(
                        File(result.imagePath),
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.eco,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      ),
              ),
            ),

            // Disease Status Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isHealthy
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isHealthy ? AppColors.success : AppColors.error,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    isHealthy ? Icons.check_circle : Icons.warning,
                    size: 48,
                    color: isHealthy ? AppColors.success : AppColors.error,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isHealthy
                        ? (locale == 'sw' ? 'Mimea ya Afya' : 'Healthy Plant')
                        : (locale == 'sw'
                            ? 'Gonjwa Limegunduliwa'
                            : 'Disease Detected'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isHealthy ? AppColors.success : AppColors.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result.diseaseName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locale == 'sw' ? 'Kuhitimisha:' : 'Confidence:',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor(result.confidence),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$confidencePercent%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Cause Section
            if (!isHealthy && diseaseInfo != null) ...[
              _SectionTitle(
                title: locale == 'sw' ? 'Sababu' : 'Cause',
                icon: Icons.help_outline,
              ),
              _ContentCard(
                child: Text(
                  diseaseInfo.getCause(locale),
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Treatment Section
            if (!isHealthy && diseaseInfo != null) ...[
              _SectionTitle(
                title: locale == 'sw' ? 'Matibabu' : 'Treatment',
                icon: Icons.healing,
              ),
              _ContentCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: diseaseInfo.getTreatmentSteps(locale)
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${entry.key + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Organic Solutions
            if (!isHealthy &&
                diseaseInfo != null &&
                diseaseInfo.getOrganicSolutions(locale).isNotEmpty) ...[
              _SectionTitle(
                title: locale == 'sw'
                    ? 'Suluhisho za Kiorgani'
                    : 'Organic Solutions',
                icon: Icons.eco,
              ),
              _ContentCard(
                child: Column(
                  children: diseaseInfo
                      .getOrganicSolutions(locale)
                      .map((solution) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.success,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    solution,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Prevention Tips
            if (!isHealthy && diseaseInfo != null) ...[
              _SectionTitle(
                title: locale == 'sw' ? 'Kuzuia' : 'Prevention',
                icon: Icons.shield,
              ),
              _ContentCard(
                child: Column(
                  children: diseaseInfo
                      .getPreventionTips(locale)
                      .map((tip) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline,
                                  color: AppColors.secondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    tip,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: Text(
                      locale == 'sw' ? 'Chunguza Tena' : 'Scan Again',
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    icon: const Icon(Icons.home),
                    label: Text(
                      locale == 'sw' ? 'Nyumbani' : 'Go Home',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return AppColors.success;
    if (confidence >= 0.6) return AppColors.secondary;
    return AppColors.error;
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final Widget child;

  const _ContentCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
