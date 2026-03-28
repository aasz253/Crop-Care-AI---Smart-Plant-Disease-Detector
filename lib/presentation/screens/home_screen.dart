import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../providers/scan_provider.dart';
import '../providers/settings_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeTab(),
          _HistoryTab(),
          _TipsTab(),
          _SettingsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final locale = settings.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'sw' ? 'CropCare AI' : 'CropCare AI'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.eco,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      locale == 'sw'
                          ? 'Chunguza Mimea Yako'
                          : 'Scan Your Plant',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      locale == 'sw'
                          ? 'Piga picha ya jani la mmea na kupata matibabu ya haraka'
                          : 'Take a photo of any plant leaf and get instant treatment',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _ActionButton(
                icon: Icons.camera_alt,
                label: locale == 'sw' ? 'Piga Picha' : 'Take Photo',
                color: AppColors.primary,
                onTap: () => _showImageSourceDialog(context),
              ),
              const SizedBox(height: 16),
              _ActionButton(
                icon: Icons.photo_library,
                label: locale == 'sw' ? 'Chagua kutoka Galeria' : 'Choose from Gallery',
                color: AppColors.secondary,
                onTap: () async {
                  final scanProvider = context.read<ScanProvider>();
                  final settingsProvider = context.read<SettingsProvider>();
                  final file = await scanProvider.pickFromGallery();
                  if (file != null && context.mounted) {
                    await scanProvider.analyzeImage(file, settingsProvider.locale);
                    if (context.mounted) {
                      Navigator.of(context).pushNamed('/result');
                    }
                  }
                },
              ),
              const SizedBox(height: 32),
              Consumer<ScanProvider>(
                builder: (context, scanProvider, child) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.analytics,
                            color: AppColors.primary,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locale == 'sw'
                                      ? 'Jumla ya Uchunguzi'
                                      : 'Total Scans',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  '${scanProvider.history.length}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();
    final locale = settingsProvider.locale;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                locale == 'sw' ? 'Chagua Chanzo' : 'Choose Source',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _SourceButton(
                      icon: Icons.camera_alt,
                      label: locale == 'sw' ? 'Kamera' : 'Camera',
                      onTap: () async {
                        Navigator.pop(context);
                        final scanProvider = context.read<ScanProvider>();
                        final file = await scanProvider.captureImage();
                        if (file != null && context.mounted) {
                          await scanProvider.analyzeImage(
                            file,
                            settingsProvider.locale,
                          );
                          if (context.mounted) {
                            Navigator.of(context).pushNamed('/result');
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SourceButton(
                      icon: Icons.photo_library,
                      label: locale == 'sw' ? 'Galeria' : 'Gallery',
                      onTap: () async {
                        Navigator.pop(context);
                        final scanProvider = context.read<ScanProvider>();
                        final file = await scanProvider.pickFromGallery();
                        if (file != null && context.mounted) {
                          await scanProvider.analyzeImage(
                            file,
                            settingsProvider.locale,
                          );
                          if (context.mounted) {
                            Navigator.of(context).pushNamed('/result');
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(icon, size: 40, color: AppColors.primary),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final locale = settings.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'sw' ? 'Historia' : 'History'),
      ),
      body: Consumer<ScanProvider>(
        builder: (context, scanProvider, child) {
          if (scanProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (scanProvider.history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 80,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    locale == 'sw'
                        ? 'Hakuna historia ya uchunguzi'
                        : 'No scan history yet',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scanProvider.history.length,
            itemBuilder: (context, index) {
              final result = scanProvider.history[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: result.diseaseId == 'healthy'
                        ? AppColors.success
                        : AppColors.error,
                    child: Icon(
                      result.diseaseId == 'healthy'
                          ? Icons.check
                          : Icons.warning,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    result.diseaseName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${result.cropType} - ${(result.confidence * 100).toStringAsFixed(1)}%',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      scanProvider.deleteFromHistory(result.id);
                    },
                  ),
                  onTap: () {
                    scanProvider.reset();
                    Navigator.of(context).pushNamed('/result');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TipsTab extends StatelessWidget {
  const _TipsTab();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final locale = settings.locale;

    final tips = [
      {
        'title': locale == 'sw' ? 'Kunywa Mapema Asubuhi' : 'Early Morning Spraying',
        'content': locale == 'sw'
            ? 'Mimina mimea yako mapema asubuhi ukiwa na baridi. Hii husaidia suluhisho liambatte vizuri.'
            : 'Spray your crops early in the morning when it\'s cool. This helps the solution stick better.',
        'icon': Icons.water_drop,
      },
      {
        'title': locale == 'sw' ? 'Nafasi Sahihi' : 'Proper Spacing',
        'content': locale == 'sw'
            ? 'Toa nafasi ya kutosha kwa mimea yako. Hii huboresha mzunguko wa hewa.'
            : 'Give your plants enough space. Proper spacing improves air circulation.',
        'icon': Icons.space_bar,
      },
      {
        'title': locale == 'sw' ? 'Ondoa Majani Yaliyoambukizwa' : 'Remove Infected Leaves',
        'content': locale == 'sw'
            ? 'Ondoa majani yaliyoambukizwa mara moja kuzuia ugonjwa kueneza.'
            : 'Remove infected leaves immediately to prevent disease spread.',
        'icon': Icons.remove_circle,
      },
      {
        'title': locale == 'sw' ? 'Mimina Maji kwenye Udongo' : 'Water at Soil Level',
        'content': locale == 'sw'
            ? 'Mimina maji kwenye shina, si kwenye majani. Majani yaliyo na maji yanaweza kusababisha maambukizi.'
            : 'Water at the base, not on leaves. Wet leaves can lead to fungal infections.',
        'icon': Icons.opacity,
      },
      {
        'title': locale == 'sw' ? 'Mabadiliko ya Mazao' : 'Crop Rotation',
        'content': locale == 'sw'
            ? 'Badilisha mazao yako kila majira. Hii husaidia kuzuia magonjwa ya udongo.'
            : 'Rotate your crops each season. This helps prevent soil-borne diseases.',
        'icon': Icons.autorenew,
      },
      {
        'title': locale == 'sw' ? 'Chunguza Mara kwa Mara' : 'Monitor Regularly',
        'content': locale == 'sw'
            ? 'Chunguza mimea yako kila siku. Kugundua mapema humaidia matibabu rahisi.'
            : 'Check your plants every day. Early detection leads to easier treatment.',
        'icon': Icons.visibility,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'sw' ? 'Vidokezo' : 'Farming Tips'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      tip['icon'] as IconData,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tip['content'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final locale = settings.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale == 'sw' ? 'Mipangilio' : 'Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: AppColors.primary),
                  title: Text(locale == 'sw' ? 'Lugha' : 'Language'),
                  subtitle: Text(locale == 'sw' ? 'Kiswahili' : 'English'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(locale == 'sw' ? 'Chagua Lugha' : 'Select Language'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('English'),
                                leading: Radio<String>(
                                  value: 'en',
                                  groupValue: settings.locale,
                                  onChanged: (value) {
                                    settings.setLocale(value!);
                                    Navigator.pop(context);
                                  },
                                ),
                                onTap: () {
                                  settings.setLocale('en');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Kiswahili'),
                                leading: Radio<String>(
                                  value: 'sw',
                                  groupValue: settings.locale,
                                  onChanged: (value) {
                                    settings.setLocale(value!);
                                    Navigator.pop(context);
                                  },
                                ),
                                onTap: () {
                                  settings.setLocale('sw');
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up, color: AppColors.primary),
                  title: Text(locale == 'sw' ? 'Patokeo la Sauti' : 'Voice Output'),
                  subtitle: Text(locale == 'sw'
                      ? 'Soma matokeo kikuu'
                      : 'Read results aloud'),
                  value: settings.voiceOutputEnabled,
                  onChanged: (value) => settings.setVoiceOutputEnabled(value),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.offline_bolt, color: AppColors.primary),
                  title: Text(locale == 'sw' ? 'Hali ya Offline' : 'Offline Mode'),
                  subtitle: Text(locale == 'sw'
                      ? 'Tumia AI ya offline'
                      : 'Use offline AI'),
                  value: settings.isOfflineMode,
                  onChanged: (value) => settings.setOfflineMode(value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info, color: AppColors.primary),
                  title: Text(locale == 'sw' ? 'Kuhusu' : 'About'),
                  subtitle: const Text('CropCare AI v1.0.0'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            locale == 'sw'
                ? 'CropCare AI - Kig检测i Mimea Mahiri\nInasaidia wakulima kugundua magonjwa ya mimea.'
                : 'CropCare AI - Smart Plant Disease Detector\nHelping African farmers detect plant diseases.',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
