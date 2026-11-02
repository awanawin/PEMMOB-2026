import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class PengaturanSiswaScreen extends StatefulWidget {
  const PengaturanSiswaScreen({super.key});

  @override
  State<PengaturanSiswaScreen> createState() => _PengaturanSiswaScreenState();
}

class _PengaturanSiswaScreenState extends State<PengaturanSiswaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/pengaturan_siswa/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
