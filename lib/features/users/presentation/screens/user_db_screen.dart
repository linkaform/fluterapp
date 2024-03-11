import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkaform/features/users/presentation/providers/get_db_docs_provider.dart';


class UserDBScreen extends ConsumerStatefulWidget {
  static String path = '/user_db';
  final String dbName;
  const UserDBScreen({super.key, required this.dbName});

  @override
  UserDBScreenState createState() => UserDBScreenState();
}

class UserDBScreenState extends ConsumerState<UserDBScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('USER DB Screen'),
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
      title: Text('ID: ${data['id']}', maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12)),
      trailing: Text('Rev: ${data['value']['rev']}', maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12)),
      subtitle: Text('Key: ${data['key']}', maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12),)

    );
  }
}
