import 'dart:io';

import 'package:flutter/material.dart';

class PowerButton extends StatelessWidget {
  const PowerButton({super.key});

  Future<void> _run(String action) => Process.run('systemctl', [action]);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Power',
      color: const Color(0xFF1C1C1E),
      icon: Icon(Icons.power_settings_new, color: Colors.black.withValues(alpha: 0.7)),
      onSelected: _run,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 'reboot',
          child: Row(
            children: [
              Icon(Icons.restart_alt, color: Colors.white),
              SizedBox(width: 12),
              Text('Restart', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'poweroff',
          child: Row(
            children: [
              Icon(Icons.power_settings_new, color: Colors.white),
              SizedBox(width: 12),
              Text('Power off', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
