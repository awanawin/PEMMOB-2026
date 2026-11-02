import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class KerjakanKuisSiswaScreen extends StatefulWidget {
  const KerjakanKuisSiswaScreen({super.key});

  @override
  State<KerjakanKuisSiswaScreen> createState() => _KerjakanKuisSiswaScreenState();
}

class _KerjakanKuisSiswaScreenState extends State<KerjakanKuisSiswaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/kerjakan_kuis_siswa/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
