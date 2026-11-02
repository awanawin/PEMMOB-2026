import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class PengumumanSiswaScreen extends StatefulWidget {
  const PengumumanSiswaScreen({super.key});

  @override
  State<PengumumanSiswaScreen> createState() => _PengumumanSiswaScreenState();
}

class _PengumumanSiswaScreenState extends State<PengumumanSiswaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/pengumuman_siswa/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
