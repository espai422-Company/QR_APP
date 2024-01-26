import 'package:flutter/material.dart';
import 'package:qr_app/widgets/widgets.dart';

/// Screen widget for displaying HTTP type scans.
class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScanTiles(tipo: 'http'),
    );
  }
}
