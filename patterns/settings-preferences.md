---
name: settings-preferences
description: Settings, preferences, and account management screen patterns for Flutter.
---

# Settings & Preferences Patterns

## Complete Settings Screen

```dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Account section
          _SettingsSection(
            title: 'Account',
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                  radius: 20,
                ),
                title: const Text('Alex Johnson'),
                subtitle: const Text('alex@example.com'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),

          // General section
          _SettingsSection(
            title: 'General',
            children: [
              ListTile(
                leading: Icon(Icons.person_outline, color: colorScheme.primary),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications_outlined, color: colorScheme.secondary),
                title: const Text('Notifications'),
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                ),
              ),
              ListTile(
                leading: Icon(Icons.language, color: colorScheme.tertiary),
                title: const Text('Language'),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),

          // Appearance section
          _SettingsSection(
            title: 'Appearance',
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode_outlined, color: colorScheme.primary),
                title: const Text('Dark Mode'),
                trailing: DropdownButton<ThemeMode>(
                  value: ThemeMode.system,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                    DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                    DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                  ],
                  onChanged: (v) {},
                ),
              ),
              ListTile(
                leading: Icon(Icons.text_fields, color: colorScheme.secondary),
                title: const Text('Text Size'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),

          // Privacy section
          _SettingsSection(
            title: 'Privacy & Security',
            children: [
              ListTile(
                leading: Icon(Icons.lock_outline, color: colorScheme.primary),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.fingerprint, color: colorScheme.secondary),
                title: const Text('Biometric Login'),
                trailing: Switch(
                  value: false,
                  onChanged: (v) {},
                ),
              ),
              ListTile(
                leading: Icon(Icons.shield_outlined, color: colorScheme.tertiary),
                title: const Text('Two-Factor Authentication'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),

          // Support section
          _SettingsSection(
            title: 'Support',
            children: [
              ListTile(
                leading: Icon(Icons.help_outline, color: colorScheme.primary),
                title: const Text('Help Center'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.star_outline, color: colorScheme.secondary),
                title: const Text('Rate App'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: colorScheme.tertiary),
                title: const Text('About'),
                subtitle: const Text('Version 1.0.0'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),

          // Danger zone
          _SettingsSection(
            title: 'Danger Zone',
            children: [
              ListTile(
                leading: Icon(Icons.logout, color: colorScheme.error),
                title: Text('Log Out', style: TextStyle(color: colorScheme.error)),
                onTap: () => _showLogoutDialog(context),
              ),
              ListTile(
                leading: Icon(Icons.delete_forever, color: colorScheme.error),
                title: Text('Delete Account', style: TextStyle(color: colorScheme.error)),
                onTap: () => _showDeleteDialog(context),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // Logout
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action is irreversible. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Delete account
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(height: 1),
        ...children,
        const Divider(height: 1),
      ],
    );
  }
}
```

## Profile Edit Screen

```dart
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _nameController = TextEditingController(text: 'Alex Johnson');
  final _bioController = TextEditingController(text: 'Fitness enthusiast');
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Name
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),

          // Bio
          TextField(
            controller: _bioController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Bio',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),

          // Gender
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: ['Male', 'Female', 'Other', 'Prefer not to say']
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: (v) => setState(() => _selectedGender = v ?? _selectedGender),
          ),
        ],
      ),
    );
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved')),
    );
    Navigator.pop(context);
  }
}
```
