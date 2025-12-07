import 'package:flutter/material.dart';

// For specifications see the following Material 3 documentation:
// - https://m3.material.io/components/bottom-sheets/specs
// - https://m3.material.io/components/side-sheets/specs

class MaterialSheet extends StatelessWidget {
  const MaterialSheet({super.key, required this.title, required this.child});

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              title,
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }

  factory MaterialSheet.modal({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return MaterialSheet(
      title: Padding(
        padding: const EdgeInsets.only(left: 16, right: 24, top: 24),
        child: Row(
          children: [_MaterialSheetCloseButton(), _MaterialSheetTitle(title)],
        ),
      ),
      child: child,
    );
  }

  factory MaterialSheet.side({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return MaterialSheet(
      title: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Row(
          children: [
            _MaterialSheetTitle(title),
            const Spacer(),
            const SizedBox(width: 12),
            _MaterialSheetCloseButton(),
          ],
        ),
      ),
      child: child,
    );
  }
}

class _MaterialSheetTitle extends StatelessWidget {
  const _MaterialSheetTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _MaterialSheetCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        semanticLabel: MaterialLocalizations.of(context).closeButtonLabel,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class MaterialSheetActionButton extends StatelessWidget {
  const MaterialSheetActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Row(
        children: [
          Expanded(
            child: FilledButton(onPressed: onPressed, child: Text(label)),
          ),
        ],
      ),
    );
  }
}
