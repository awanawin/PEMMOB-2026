import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class DaftarPengumpulanTugasScreen extends StatefulWidget {
  const DaftarPengumpulanTugasScreen({super.key});

  @override
  State<DaftarPengumpulanTugasScreen> createState() => _DaftarPengumpulanTugasScreenState();
}

class _DaftarPengumpulanTugasScreenState extends State<DaftarPengumpulanTugasScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/daftar_pengumpulan_tugas/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
