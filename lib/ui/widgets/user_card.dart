import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/domain/model/user_model.dart';
import 'package:suitmedia_test/ui/pages/second_screen.dart';
import 'package:suitmedia_test/ui/provider/users/user_state_provider.dart';

class UserCard extends ConsumerWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        ref.read(userStateProvider.notifier).state = user;
        Navigator.pushReplacementNamed(context, SecondScreen.routePath);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: CachedNetworkImageProvider(user.avatar!),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${user.firstName!} ${user.lastName!}",
                    style: textTheme.bodyLarge!
                        .apply(fontWeightDelta: 2, fontSizeDelta: 4)),
                Text(user.email!,
                    style: textTheme.bodyMedium!.apply(fontSizeDelta: 2)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
