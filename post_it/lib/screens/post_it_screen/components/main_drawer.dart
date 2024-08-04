import 'package:flutter/material.dart';
import 'package:post_it/core/services/auth/auth_mock_service.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 200,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                AuthMockService().logout();
              },
              label: Text('Sair!'),
            ),
          ],
        ),
      ),
    );
  }
}
