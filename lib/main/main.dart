import 'package:flutter/material.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_type_cm.dart';
import 'package:ioasys_app/main/my_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter<EnterpriseCM>(EnterpriseCMAdapter())
    ..registerAdapter<EnterpriseTypeCM>(EnterpriseTypeCMAdapter());

  runApp(const MyApp());
}
