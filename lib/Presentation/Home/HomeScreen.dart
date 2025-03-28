import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:urban_clutur_streak_system/Domain/service/DatabaseService.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  var streakGoalOneImageProvider = StateProvider<File?>((ref) => null);
  var streakGoalTwoImageProvider = StateProvider<File?>((ref) => null);
  var streakGoalThreeImageProvider = StateProvider<File?>((ref) => null);
  var streakGoalFourImageProvider = StateProvider<File?>((ref) => null);
  var streakGoalFiveImageProvider = StateProvider<File?>((ref) => null);
  var streakGoalSixImageProvider = StateProvider<File?>((ref) => null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        taskLayout(),
        ElevatedButton(
            onPressed: () {
              if (ref.watch(streakGoalOneImageProvider) == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select first image')));
              } else if (ref.watch(streakGoalTwoImageProvider) == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: const Text('Please select second image')));
              } else if (ref.watch(streakGoalThreeImageProvider) == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select third image')));
              } else if (ref.watch(streakGoalFourImageProvider) == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please select fourth image')));
              } else if (ref.watch(streakGoalFiveImageProvider) == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select fifth image')));
              } else {
                var isCurrentDay = false;
                ref.watch(streaksProvider).get().then((value) {
                  if (value.docs.isEmpty) {
                    ref.watch(streaksProvider).add({
                      "date": DateTime.now(),
                      "image1": base64Encode(ref
                          .watch(streakGoalOneImageProvider)!
                          .readAsBytesSync()),
                      "image2": base64Encode(ref
                          .watch(streakGoalOneImageProvider)!
                          .readAsBytesSync()),
                      "image3": base64Encode(ref
                          .watch(streakGoalOneImageProvider)!
                          .readAsBytesSync()),
                      "image4": base64Encode(ref
                          .watch(streakGoalOneImageProvider)!
                          .readAsBytesSync()),
                      "image5": base64Encode(ref
                          .watch(streakGoalOneImageProvider)!
                          .readAsBytesSync()),
                    });
                  } else {
                    for (int i = 0; i < value.docs.length; i++) {
                      var time = DateTime.fromMillisecondsSinceEpoch(
                          (value.docs[i]['date'] as Timestamp)
                              .millisecondsSinceEpoch);

                      if (time.day == DateTime.now().day) {
                        isCurrentDay = true;
                      }
                    }
                    if (isCurrentDay == false) {
                      ref.watch(streaksProvider).add({
                        "date": DateTime.now(),
                        "image1": base64Encode(ref
                            .watch(streakGoalOneImageProvider)!
                            .readAsBytesSync()),
                        "image2": base64Encode(ref
                            .watch(streakGoalOneImageProvider)!
                            .readAsBytesSync()),
                        "image3": base64Encode(ref
                            .watch(streakGoalOneImageProvider)!
                            .readAsBytesSync()),
                        "image4": base64Encode(ref
                            .watch(streakGoalOneImageProvider)!
                            .readAsBytesSync()),
                        "image5": base64Encode(ref
                            .watch(streakGoalOneImageProvider)!
                            .readAsBytesSync()),
                      });
                    }
                  }
                });
              }
            },
            child: const Text('Submit'))
      ],
    );
  }

  Widget taskLayout() => Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ref.watch(streakGoalOneImageProvider) == null
                        ? Colors.grey
                        : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.done),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cleanser'),
                    Text('Cetafil Gentle Skin Cleanser')
                  ],
                ),
              )),
              IconButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        ref.watch(streakGoalOneImageProvider.notifier).state =
                            File(value.path);
                      }
                    });
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              Text(DateFormat('h:mm a').format(DateTime.now()))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ref.watch(streakGoalTwoImageProvider) == null
                        ? Colors.grey
                        : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.done),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Toner'), Text('Thayers witch hazel tower')],
                ),
              )),
              IconButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        ref.watch(streakGoalTwoImageProvider.notifier).state =
                            File(value.path);
                      }
                    });
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              Text(DateFormat('h:mm a').format(DateTime.now()))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ref.watch(streakGoalThreeImageProvider) == null
                        ? Colors.grey
                        : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.done),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Moisturiser'),
                    Text('Kehil\'s ultra facial cream')
                  ],
                ),
              )),
              IconButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        ref.watch(streakGoalThreeImageProvider.notifier).state =
                            File(value.path);
                      }
                    });
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              Text(DateFormat('h:mm a').format(DateTime.now()))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ref.watch(streakGoalFourImageProvider) == null
                        ? Colors.grey
                        : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.done),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sunscreen'),
                    Text('Super goop unseen sunscreen spf 40')
                  ],
                ),
              )),
              IconButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        ref.watch(streakGoalFourImageProvider.notifier).state =
                            File(value.path);
                      }
                    });
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              Text(DateFormat('h:mm a').format(DateTime.now()))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ref.watch(streakGoalFiveImageProvider) == null
                        ? Colors.grey
                        : Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.done),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                  child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lip Balm'),
                    Text('Glossier Birthday Balm Doctor')
                  ],
                ),
              )),
              IconButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        ref.watch(streakGoalFiveImageProvider.notifier).state =
                            File(value.path);
                      }
                    });
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              Text(DateFormat('h:mm a').format(DateTime.now()))
            ],
          ),
        ],
      );
}
