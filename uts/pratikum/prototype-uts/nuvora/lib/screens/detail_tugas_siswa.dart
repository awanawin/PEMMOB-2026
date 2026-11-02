import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class DetailTugasSiswaScreen extends StatefulWidget {
  const DetailTugasSiswaScreen({super.key});

  @override
  State<DetailTugasSiswaScreen> createState() => _DetailTugasSiswaScreenState();
}

class _DetailTugasSiswaScreenState extends State<DetailTugasSiswaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/detail_tugas_siswa/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
