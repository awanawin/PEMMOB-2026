import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class DaftarKelasGuruScreen extends StatefulWidget {
  const DaftarKelasGuruScreen({super.key});

  @override
  State<DaftarKelasGuruScreen> createState() => _DaftarKelasGuruScreenState();
}

class _DaftarKelasGuruScreenState extends State<DaftarKelasGuruScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/daftar_kelas_guru/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
