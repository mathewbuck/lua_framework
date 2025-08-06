class LuaError implements Exception {
  final String message;
  LuaError(this.message);

  @override
  String toString() => '🛑 LuaError: $message';
}