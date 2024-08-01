import 'package:flutter/material.dart';
import 'package:linkaform/core/rest_config/api_provider.dart';

import '../../../core/common/core_exports.dart';

class CouchDbDocWidget extends ConsumerStatefulWidget {
  static String path = 'doc_data/:docId';
  static String name = 'doc_data';

  final String dbName;
  final String docId;

  const CouchDbDocWidget(
      {super.key, required this.dbName, required this.docId});

  @override
  CouchDbDocWidgetState createState() => CouchDbDocWidgetState();
}

class CouchDbDocWidgetState extends ConsumerState<CouchDbDocWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doc data screen'),
      ),
      body: FutureBuilder(
        future: ref.watch(apiProvider).getDocData(widget.dbName, widget.docId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return snapshot.data
                    ?.fold((l) => Text(l), (r) => Text(r.toString())) ??
                const Text('No data');
          }
        },
      ),
    );
  }
}
