import 'package:lua_framework/lua_runtime.dart';

void main() {
  final lua = LuaRuntime();
  lua.runFile('scripts/init.lua');
  lua.dispose();
}

