import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suitmedia_test/ui/pages/second_screen.dart';
import 'package:suitmedia_test/ui/provider/users/user_state_notifier_provider.dart';
import 'package:suitmedia_test/ui/widgets/my_app_bar.dart';
import 'package:suitmedia_test/ui/widgets/user_card.dart';

class ThirdScreen extends ConsumerStatefulWidget {
  static const routePath = "/third-screen";
  const ThirdScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends ConsumerState<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  bool isEmptyData = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  bool _onEndScroll(scrollNotification) {
    if (scrollNotification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      ref.read(userNotifierProvider.notifier).loadMore().then((value) {
        setState(() {
          isEmptyData = !value;
        });
        if (!value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No more data to load")));
        }
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final userNotifierRef = ref.watch(userNotifierProvider);
    return Scaffold(
        appBar: myAppBar(context, "Third Screen",
            action: () => Navigator.pushReplacementNamed(
                context, SecondScreen.routePath)),
        backgroundColor: Colors.white,
        body: userNotifierRef.when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text("No Data"),
                );
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: _onEndScroll,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .refresh(userNotifierProvider.notifier)
                          .getUsers();
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.all(16),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final user = data[index];
                              return UserCard(user: user);
                            },
                            itemCount: data.length,
                          ),
                          !isEmptyData
                              ? Container(
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            error: (e, s) => Center(
                  child: Text("Error => $e"),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
