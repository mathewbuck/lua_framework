// lib/lua_runtime.dart
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:lua_framework/lua_bindings.dart';
import 'package:lua_framework/lua_error.dart';

class LuaRuntime {
  late final LuaState _state;

  LuaRuntime() {
    _state = luaLNewState();
    luaLOpenLibs(_state);
  }

  void run(String code) {
    final codePtr = code.toNativeUtf8();
    final loadResult = luaLLoadString(_state, codePtr);
    calloc.free(codePtr);

    if (loadResult != 0) {
      final errMsg = _getLuaError();
      // luaPop(_state, 1); // Clean up error from stack // commented out to test.
      throw LuaError('Load error: $errMsg');
    }

    final callResult = luaPCall(_state, 0, -1, 0);
    if (callResult != 0) {
      final errMsg = _getLuaError();
      //luaPop(_state, 1); // Clean up error from stack
      throw LuaError('Runtime error: $errMsg');
    }
  }

  void runFile(String path) {
    final code = File(path).readAsStringSync();
    run(code);
  }

  String _getLuaError() {
    final lengthPtr = calloc<IntPtr>();
    final msgPtr = luaToLString(_state, -1, lengthPtr);
    final message = msgPtr == nullptr ? 'Unknown Lua error' : msgPtr.toDartString();
    calloc.free(lengthPtr);
    return message;
  }

  void dispose() {
    luaClose(_state);
  }
}
