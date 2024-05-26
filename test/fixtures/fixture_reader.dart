import 'dart:io';

String fixture(String fileName){
  File file =  File('${Directory.current.path}/test/fixtures/$fileName');
  String content = file.readAsStringSync();
  return content;
}