import 'dart:async';

import 'package:flutter/material.dart';

/// Placeholder PS5-style console home screen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _AppTile {
  const _AppTile(this.name, this.subtitle, this.colors, this.icon);

  final String name;
  final String subtitle;
  final List<Color> colors;
  final IconData icon;
}

class _HomeScreenState extends State<HomeScreen> {
  static const _tiles = [
    _AppTile('Media Center', 'Movies & TV',
        [Color(0xFF1A2980), Color(0xFF26D0CE)], Icons.movie_outlined),
    _AppTile('Music', 'Your library',
        [Color(0xFF41295A), Color(0xFF2F0743)], Icons.music_note_outlined),
    _AppTile('Browser', 'Explore the web',
        [Color(0xFF136A8A), Color(0xFF267871)], Icons.public),
    _AppTile('Photos', 'Memories',
        [Color(0xFFCB356B), Color(0xFFBD3F32)], Icons.photo_outlined),
    _AppTile('Games', 'Coming soon',
        [Color(0xFF283C86), Color(0xFF45A247)], Icons.sports_esports_outlined),
    _AppTile('Settings', 'System',
        [Color(0xFF232526), Color(0xFF414345)], Icons.settings_outlined),
    _AppTile('Store', 'Get more apps',
        [Color(0xFF0F2027), Color(0xFF2C5364)], Icons.shopping_bag_outlined),
  ];

  int _selected = 0;
  int _tab = 0;
  late Timer _clockTimer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  String get _clock {
    final h = _now.hour % 12 == 0 ? 12 : _now.hour % 12;
    final m = _now.minute.toString().padLeft(2, '0');
    final ampm = _now.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $ampm';
  }

  @override
  Widget build(BuildContext context) {
    final tile = _tiles[_selected];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              tile.colors.first.withValues(alpha: 0.85),
              const Color(0xFF0D1117),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(),
              const SizedBox(height: 24),
              _tileRow(),
              const Spacer(),
              _heroArea(tile),
              const Spacer(flex: 2),
              _bottomHints(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 24, 48, 0),
      child: Row(
        children: [
          _tabLabel('Apps', 0),
          const SizedBox(width: 28),
          _tabLabel('Media', 1),
          const Spacer(),
          const Icon(Icons.search, color: Colors.white70, size: 26),
          const SizedBox(width: 24),
          const Icon(Icons.settings_outlined, color: Colors.white70, size: 26),
          const SizedBox(width: 24),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_outline, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 24),
          Text(
            _clock,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabLabel(String label, int index) {
    final active = _tab == index;
    return GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: active ? Colors.white : Colors.white54,
          fontSize: 20,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
        ),
        child: Text(label),
      ),
    );
  }

  Widget _tileRow() {
    return SizedBox(
      height: 132,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        scrollDirection: Axis.horizontal,
        itemCount: _tiles.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, i) {
          final selected = i == _selected;
          final tile = _tiles[i];
          return GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              width: selected ? 132 : 104,
              height: selected ? 132 : 104,
              margin: EdgeInsets.only(top: selected ? 0 : 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: tile.colors,
                ),
                borderRadius: BorderRadius.circular(12),
                border: selected
                    ? Border.all(color: Colors.white, width: 2.5)
                    : null,
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Icon(tile.icon,
                  color: Colors.white, size: selected ? 52 : 40),
            ),
          );
        },
      ),
    );
  }

  Widget _heroArea(_AppTile tile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tile.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tile.subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 20),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${tile.name} not implemented yet')),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Open',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _bottomHints() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 0, 48, 24),
      child: Row(
        children: const [
          Icon(Icons.touch_app_outlined, color: Colors.white38, size: 18),
          SizedBox(width: 8),
          Text('Tap a tile to select · Tap Open to launch',
              style: TextStyle(color: Colors.white38, fontSize: 14)),
        ],
      ),
    );
  }
}
