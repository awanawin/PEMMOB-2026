import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// HTML asli dari Stitch dipertahankan untuk menjaga kemiripan visual.
class EditProfilGuruScreen extends StatefulWidget {
  const EditProfilGuruScreen({super.key});

  @override
  State<EditProfilGuruScreen> createState() => _EditProfilGuruScreenState();
}

class _EditProfilGuruScreenState extends State<EditProfilGuruScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF9F9FF))
      ..loadFlutterAsset('assets/screens/edit_profil_guru/index.html');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: WebViewWidget(controller: _controller)),
  );
}
