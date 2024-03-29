import 'package:flutter/material.dart';
import 'package:qr_app/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

void lauchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipo == 'http') {
    // Abrir el sitio web
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  } else {
    // Abrir el mapa
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
