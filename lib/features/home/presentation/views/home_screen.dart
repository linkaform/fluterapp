import 'package:flutter/material.dart';

import '../../../../core/common/core_exports.dart';
import '../providers/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String path = '/home_screen';

  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: ref.watch(getAllDBProvider).when(
            data: (data) => data.fold(
                  (l) => null,
                  (success) => ListView.builder(
                    itemCount: success.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(success[index]),
                        onTap: () => ref.read(appRouterProvider).pushNamed(
                            DatabaseDocsScreen.name,
                            pathParameters: {'db': success[index]}),
                      );
                    },
                  ),
                ),
            error: (error, _) => Text(error.toString()),
            loading: () => const CircularProgressIndicator()));
  }
}
