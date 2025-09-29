// lib/presentation/pages/settings/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/presentation/blocs/theme/theme_bloc.dart';
import 'package:mylifetime/presentation/blocs/backup/backup_bloc.dart';
import 'package:mylifetime/presentation/widgets/common/glass_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildThemeSection(context),
          const SizedBox(height: 16),
          _buildBackupSection(context),
          const SizedBox(height: 16),
          _buildAboutSection(context),
        ],
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildThemeModeSelector(context),
          const SizedBox(height: 16),
          _buildAccentColorSelector(context),
        ],
      ),
    );
  }

  Widget _buildThemeModeSelector(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Mode',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('Light'),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('System'),
                ),
              ],
              selected: {state.themeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                context.read<ThemeBloc>().add(
                  ChangeTheme(newSelection.first),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAccentColorSelector(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accent Color',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: colors.map((color) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isSelected = state.accentColor.value == color.value;
                return GestureDetector(
                  onTap: () {
                    context.read<ThemeBloc>().add(ChangeAccentColor(color));
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: color.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBackupSection(BuildContext context) {
    return BlocConsumer<BackupBloc, BackupState>(
      listener: (context, state) {
        if (state is BackupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is BackupCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backup created successfully')),
          );
        } else if (state is BackupRestored) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backup restored successfully')),
          );
        }
      },
      builder: (context, state) {
        return GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Backup & Restore',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (state is BackupLoading)
                const LinearProgressIndicator()
              else
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<BackupBloc>().add(CreateBackupEvent());
                      },
                      child: const Text('Create Backup'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _showRestoreDialog,
                      child: const Text('Restore Backup'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        context.read<BackupBloc>().add(ExportDataEvent('csv'));
                      },
                      child: const Text('Export to CSV'),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Backup'),
        content: const Text('This will replace all current data with the backup. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement file picker for backup restoration
            },
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }
}