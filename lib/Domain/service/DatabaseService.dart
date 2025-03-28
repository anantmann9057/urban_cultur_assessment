import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var firebaseDatabaseProvider = Provider((ref) => FirebaseFirestore.instance);
var streaksProvider =
    Provider((ref) => ref.read(firebaseDatabaseProvider).collection('streaks'));
    
    var streaksStream =
    StreamProvider((ref) => ref.read(firebaseDatabaseProvider).collection('streaks').get().asStream());

var usersProvider =
    Provider((ref) => ref.read(firebaseDatabaseProvider).collection('users'));

Future<File?> pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['png'],
  );

  return Future(() => File(result!.files.single.path ?? ""));
}

Future<File?> pickPdf() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  return Future(() => File(result!.files.single.path ?? ""));
}
