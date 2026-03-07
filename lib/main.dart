import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_health_camp/todo_app.dart';

void main(){
  runApp(
     const ProviderScope(child:  TodoApp())
  );
}

