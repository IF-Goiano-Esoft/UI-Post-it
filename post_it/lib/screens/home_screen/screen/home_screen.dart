import 'package:flutter/material.dart';
import 'package:post_it/data/post_it_list.dart';
import 'package:post_it/models/post_it.dart';
import 'package:post_it/screens/home_screen/components/card_post_it.dart';
import 'package:post_it/utils/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<PostIt> _postIts = List.from(PostItList.postIts);

  void _addPostIt(PostIt postIt) {
    setState(() {
      _postIts.add(postIt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post-It'),
        actions: [
          IconButton(
            onPressed: () async {
              final result =
                  await Navigator.of(context).pushNamed(AppRoutes.NEW_POST_IT);
              if (result != null && result is PostIt) {
                _addPostIt(result);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _postIts.isEmpty
          ? Center(
              child: TextButton.icon(
                onPressed: () async {
                  final result = await Navigator.of(context)
                      .pushNamed(AppRoutes.NEW_POST_IT);
                  if (result != null && result is PostIt) {
                    _addPostIt(result);
                  }
                },
                label: const Text('Adicionar Novo Post It'),
                icon: const Icon(Icons.add),
              ),
            )
          : Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 20,
                ),
                itemCount: _postIts.length,
                itemBuilder: (ctx, index) {
                  return CardPostIt(_postIts[index]);
                },
              ),
            ),
    );
  }
}
