import 'package:flutter/material.dart';

import '../widgets/tile_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 32),
          children: const [
            TileRow(title: 'Continue', itemCount: 6),
            SizedBox(height: 32),
            TileRow(title: 'Apps', itemCount: 8),
            SizedBox(height: 32),
            TileRow(title: 'Media', itemCount: 5),
          ],
        ),
      ),
    );
  }
}
