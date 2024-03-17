import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/features/db_docs/presentation/providers/get_db_docs_provider.dart';

class DatabaseDocsScreen extends ConsumerStatefulWidget {
  static String path = 'user_db/:db';
  static String name = 'user_db';

  final String dbName;
  const DatabaseDocsScreen({super.key, required this.dbName});

  @override
  UDatabaseDocsScreenState createState() => UDatabaseDocsScreenState();
}

class UDatabaseDocsScreenState extends ConsumerState<DatabaseDocsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DB docs screen'),
        ),
        body: ref.watch(getDBDocsProvider(widget.dbName)).when(
            data: (data) => data.fold(
                  (l) => null,
                  (success) => ListView.builder(
                    itemCount: success.length,
                    itemBuilder: (context, index) {
                      return listTileDoc(data: success[index]);
                    },
                  ),
                ),
            error: (error, _) => Text(error.toString()),
            loading: () => const CircularProgressIndicator()));
  }

  Widget listTileDoc({required Map<String, dynamic> data}) {
    return ListTile(
        title: Text('ID: ${data['id']}',
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12)),
        trailing: Text('Rev: ${data['value']['rev']}',
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12)),
        subtitle: Text(
          'Key: ${data['key']}',
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ));
  }
}
