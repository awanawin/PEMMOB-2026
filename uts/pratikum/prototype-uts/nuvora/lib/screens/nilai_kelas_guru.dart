import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class NilaiKelasGuruScreen extends StatefulWidget {
  const NilaiKelasGuruScreen({super.key});

  @override
  State<NilaiKelasGuruScreen> createState() => _NilaiKelasGuruScreenState();
}

class _NilaiKelasGuruScreenState extends State<NilaiKelasGuruScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/nilai_kelas_guru/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
