import 'package:flutter/material.dart';
import 'package:post_it/core/services/auth/auth_service.dart';
import 'package:post_it/core/services/post_it/post_it_service.dart';
import 'package:post_it/core/models/post_it.dart';
import 'package:post_it/screens/post_it_screen/components/card_post_it.dart';
import 'package:post_it/screens/post_it_screen/components/main_drawer.dart';
import 'package:post_it/utils/app_routes.dart';

class PostItScreen extends StatefulWidget {
  const PostItScreen({super.key});

  @override
  State<PostItScreen> createState() => _PostItScreenState();
}

class _PostItScreenState extends State<PostItScreen> {
  final Stream<List<PostIt>> _postIts =
      PostItService().postItsByUserStream(AuthService().currentUser!);

  void _deletePostIt(PostIt post) {
    PostItService().remove(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Post-It'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).pushNamed(AppRoutes.NEW_POST_IT);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _postIts,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: TextButton.icon(
                onPressed: () async {
                  Navigator.of(context).pushNamed(AppRoutes.NEW_POST_IT);
                },
                label: const Text('Adicionar Novo Post It'),
                icon: const Icon(Icons.add),
              ),
            );
          } else {
            List<PostIt> postIts = snapshot.data!;
            return Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 215,
                  childAspectRatio: 7 / 5,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5,
                ),
                itemCount: postIts.length,
                itemBuilder: (ctx, index) {
                  return CardPostIt(
                    postIts[index],
                    () => _deletePostIt(postIts[index]),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
