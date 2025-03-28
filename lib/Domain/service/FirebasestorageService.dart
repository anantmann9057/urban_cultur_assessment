import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var uploadTaskProvider = Provider<Reference>((ref) => FirebaseStorage.instance
    .ref()
    .child('streaks/${DateTime.now().millisecondsSinceEpoch}.png'));

var uploadStreamProvider =
    StreamProvider.family<TaskSnapshot, File>((ref, file) {
  return ref
      .watch(uploadTaskProvider)
      .putFile(
        file,
      )
      .snapshotEvents;
});
