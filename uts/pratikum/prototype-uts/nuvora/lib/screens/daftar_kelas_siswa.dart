import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class DaftarKelasSiswaScreen extends StatefulWidget {
  const DaftarKelasSiswaScreen({super.key});

  @override
  State<DaftarKelasSiswaScreen> createState() => _DaftarKelasSiswaScreenState();
}

class _DaftarKelasSiswaScreenState extends State<DaftarKelasSiswaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/daftar_kelas_siswa/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
