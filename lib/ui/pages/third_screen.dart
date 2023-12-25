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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  bool _onEndScroll(scrollNotification) {
    if (scrollNotification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      ref.read(userNotifierProvider.notifier).loadMore();
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
                final isExists =
                    ref.read(userNotifierProvider.notifier).isExist;
                return _refreshWrapper(
                  isScroll: false,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _onEndScroll,
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
                          isExists
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
            error: (e, s) {
              return _refreshWrapper(
                child: Center(
                  child: Text("Error => $e"),
                ),
              );
            },
            loading: () => _refreshWrapper(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )));
  }

  Widget _refreshWrapper({required Widget child, bool isScroll = true}) {
    return RefreshIndicator(
        onRefresh: () => ref.refresh(userNotifierProvider.notifier).getUsers(),
        child: isScroll
            ? LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                            minWidth: constraints.maxWidth),
                        child: IntrinsicHeight(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [const Spacer(), child, const Spacer()],
                        )),
                      ),
                    ))
            : child);
  }
}
