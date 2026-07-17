import 'package:flutter/material.dart';

/// Minimal on-screen keyboard for the kiosk (cage has no system OSK).
/// Emits characters via [onKey], backspace via [onBackspace], submit via
/// [onSubmit]. Three layers: lowercase, uppercase (shift), symbols.
class OnscreenKeyboard extends StatefulWidget {
  const OnscreenKeyboard({
    super.key,
    required this.onKey,
    required this.onBackspace,
    required this.onSubmit,
  });

  final ValueChanged<String> onKey;
  final VoidCallback onBackspace;
  final VoidCallback onSubmit;

  @override
  State<OnscreenKeyboard> createState() => _OnscreenKeyboardState();
}

class _OnscreenKeyboardState extends State<OnscreenKeyboard> {
  static const _ink = Color(0xFF1C1C1E);

  static const _lower = [
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
    ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
    ['z', 'x', 'c', 'v', 'b', 'n', 'm'],
  ];
  static const _symbols = [
    ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
    ['-', '_', '@', '#', '\$', '%', '&', '*', '+'],
    ['!', '?', '.', ',', ':', ';', '/', '"', "'"],
    ['(', ')', '[', ']', '{', '}', '<', '>', '=', '~', '^'],
  ];

  bool _shift = false;
  bool _symbolsPage = false;

  @override
  Widget build(BuildContext context) {
    final rows = _symbolsPage ? _symbols : _lower;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in rows)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final key in row)
                _key(
                  label: _shift && !_symbolsPage ? key.toUpperCase() : key,
                  onTap: () {
                    widget.onKey(
                      _shift && !_symbolsPage ? key.toUpperCase() : key,
                    );
                    if (_shift) setState(() => _shift = false);
                  },
                ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _key(
              label: _symbolsPage ? 'abc' : '?123',
              flex: 2,
              onTap: () => setState(() => _symbolsPage = !_symbolsPage),
            ),
            if (!_symbolsPage)
              _key(
                label: '⇧',
                flex: 2,
                active: _shift,
                onTap: () => setState(() => _shift = !_shift),
              ),
            _key(label: 'space', flex: 5, onTap: () => widget.onKey(' ')),
            _key(label: '⌫', flex: 2, onTap: widget.onBackspace),
            _key(
              label: 'done',
              flex: 3,
              filled: true,
              onTap: widget.onSubmit,
            ),
          ],
        ),
      ],
    );
  }

  Widget _key({
    required String label,
    required VoidCallback onTap,
    int flex = 1,
    bool active = false,
    bool filled = false,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: filled
              ? _ink
              : active
                  ? const Color(0xFFE3CDF6)
                  : const Color(0xFFF4F4F6),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: SizedBox(
              height: 52,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: filled ? Colors.white : _ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
