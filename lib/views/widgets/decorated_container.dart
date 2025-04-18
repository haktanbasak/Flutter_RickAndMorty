import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget topChild;
  final Widget child;
  const DecoratedContainer({
    super.key,
    required this.child,
    required this.topChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg-image.png'),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        children: [
          topChild,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
