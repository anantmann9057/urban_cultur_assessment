import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_clutur_streak_system/Domain/service/DatabaseService.dart';

class Streaksscreen extends ConsumerStatefulWidget {
  const Streaksscreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StreaksscreenState();
}

class _StreaksscreenState extends ConsumerState<Streaksscreen> {
  var currentStreakProvider = StateProvider((ref) => 0);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentStreak();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ref.watch(streaksStream).when(
            data: (data) {
              return Column(
                children: [
                  Text("Todays Goal: ${ref.watch(currentStreakProvider) + 1} Streak Days"),
                  Text("Streaks: ${ref.watch(currentStreakProvider)}")
                ],
              );
            },
            error: (e, s) => Container(),
            loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                )),
      ],
    );
  }

  void getCurrentStreak() {
    ref.watch(streaksProvider).get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        var time = DateTime.fromMillisecondsSinceEpoch(
            (value.docs[i]['date'] as Timestamp).millisecondsSinceEpoch);

        if (value.docs.length > 1 && i>0) {
          var previousTime = DateTime.fromMillisecondsSinceEpoch(
              (value.docs[i-1]['date'] as Timestamp).millisecondsSinceEpoch);

          if (previousTime.difference(time).inDays > 1) {
            ref.watch(currentStreakProvider.notifier).state = 0;
          } else {
            ref.watch(currentStreakProvider.notifier).state = value.docs.length-1;
          }
        }
        if (time.day == DateTime.now().day) {}
      }
    });
  }
}
