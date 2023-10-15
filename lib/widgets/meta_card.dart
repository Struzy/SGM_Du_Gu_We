import 'package:flutter/material.dart';

class MetaCard extends StatelessWidget {
  const MetaCard(this.title, this.children, {super.key});

  final String title;
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(title, style: const TextStyle(fontSize: 18)),
              ),
              children,
            ],
          ),
        ),
      ),
    );
  }
}
