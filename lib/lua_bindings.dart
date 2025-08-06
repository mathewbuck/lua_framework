import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart'; // Needed for Utf8

/// Load the correct Lua dynamic library based on platform
final DynamicLibrary luaLib = () {
  if (Platform.isLinux || Platform.isAndroid) {
    return DynamicLibrary.open('native/linux/liblua.so');
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('native/windows/lua.dll');
  }
  throw UnsupportedError('Unsupported platform: ${Platform.operatingSystem}');
}();

/// Lua state type alias
typedef LuaState = Pointer<Void>;

/// Bind luaL_newstate
typedef LuaLNewStateC = LuaState Function();
typedef LuaLNewStateDart = LuaState Function();

final LuaLNewStateDart luaLNewState =
    luaLib.lookupFunction<LuaLNewStateC, LuaLNewStateDart>('luaL_newstate');

/// Bind luaL_openlibs
typedef LuaLOpenLibsC = Void Function(LuaState);
typedef LuaLOpenLibsDart = void Function(LuaState);

final LuaLOpenLibsDart luaLOpenLibs =
    luaLib.lookupFunction<LuaLOpenLibsC, LuaLOpenLibsDart>('luaL_openlibs');

/// Bind lua_close
typedef LuaCloseC = Void Function(LuaState);
typedef LuaCloseDart = void Function(LuaState);

final LuaCloseDart luaClose =
    luaLib.lookupFunction<LuaCloseC, LuaCloseDart>('lua_close');

/// Bind luaL_loadstring
typedef LuaLLoadStringC = Int32 Function(LuaState, Pointer<Utf8>);
typedef LuaLLoadStringDart = int Function(LuaState, Pointer<Utf8>);

final LuaLLoadStringDart luaLLoadString =
    luaLib.lookupFunction<LuaLLoadStringC, LuaLLoadStringDart>('luaL_loadstring');

/// Bind lua_pcall
typedef LuaPCallC = Int32 Function(LuaState, Int32, Int32, Int32);
typedef LuaPCallDart = int Function(LuaState, int, int, int);

final LuaPCallDart luaPCall =
    luaLib.lookupFunction<LuaPCallC, LuaPCallDart>('lua_pcall');

/// Bind lua_tolstring
typedef LuaToLStringC = Pointer<Utf8> Function(LuaState, Int32, Pointer<IntPtr>);
typedef LuaToLStringDart = Pointer<Utf8> Function(LuaState, int, Pointer<IntPtr>);

final LuaToLStringDart luaToLString =
    luaLib.lookupFunction<LuaToLStringC, LuaToLStringDart>('lua_tolstring');

/// Bind lua_pop
typedef LuaPopC = Void Function(LuaState, Int32);
typedef LuaPopDart = void Function(LuaState, int);

final LuaPopDart luaPop =
    luaLib.lookupFunction<LuaPopC, LuaPopDart>('lua_pop');

