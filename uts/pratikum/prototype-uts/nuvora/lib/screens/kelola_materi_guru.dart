import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class KelolaMateriGuruScreen extends StatefulWidget {
  const KelolaMateriGuruScreen({super.key});

  @override
  State<KelolaMateriGuruScreen> createState() => _KelolaMateriGuruScreenState();
}

class _KelolaMateriGuruScreenState extends State<KelolaMateriGuruScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/kelola_materi_guru/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
