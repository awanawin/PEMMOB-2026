import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class BuatTugasGuruScreen extends StatefulWidget {
  const BuatTugasGuruScreen({super.key});

  @override
  State<BuatTugasGuruScreen> createState() => _BuatTugasGuruScreenState();
}

class _BuatTugasGuruScreenState extends State<BuatTugasGuruScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/buat_tugas_guru/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
