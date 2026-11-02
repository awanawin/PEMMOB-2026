import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class BuatKuisGuruScreen extends StatefulWidget {
  const BuatKuisGuruScreen({super.key});

  @override
  State<BuatKuisGuruScreen> createState() => _BuatKuisGuruScreenState();
}

class _BuatKuisGuruScreenState extends State<BuatKuisGuruScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/buat_kuis_guru/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
