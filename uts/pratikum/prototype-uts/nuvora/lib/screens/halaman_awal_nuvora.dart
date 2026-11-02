import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class HalamanAwalNuvoraScreen extends StatefulWidget {
  const HalamanAwalNuvoraScreen({super.key});

  @override
  State<HalamanAwalNuvoraScreen> createState() => _HalamanAwalNuvoraScreenState();
}

class _HalamanAwalNuvoraScreenState extends State<HalamanAwalNuvoraScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/halaman_awal_nuvora/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
