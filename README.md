```
┌────────────────────────────────────┐
│          Dart Framework            │
│ ────────────────────────────────── │
│ • CLI tooling & scaffolding        │
│ • HTTP/TCP client abstraction      │
│ • Lua FFI bridge manager           │
│ • Shared config and diagnostics    │
└──────────────┬─────────────────────┘
               │ FFI
               ▼
┌────────────────────────────────────┐
│           Lua Microkernel          │
│ ────────────────────────────────── │
│ • HTTP/TCP server (Express-style)  │
│ • Route dispatcher (app.get, etc.) │
│ • PostgreSQL client                │
│ • Middleware hooks / utilities     │
└────────────────────────────────────┘

Framework File Structure:
lua_framework/
├── bin/
│   └── main.dart              ← Entry point
├── lib/
│   ├── lua_bindings.dart      ← FFI bindings
│   └── lua_runtime.dart       ← Lua engine class
├── scripts/
│   └── init.lua               ← User Lua code
├── native/
│   ├── windows/lua.dll
│   └── linux/liblua.so
```
Merknader fra byggingen:
- Last ned lua 5.1.5-kildekoden
{ Vil feil fra flere koblede main() rydde opp i det for å fortsette - }
- Bygg lualib.so med make / GCC { Dette er kun for Linux / Android }
- Bygg lua.dll { bygget med utviklerens PowerShell for vs 2022 }
- Bygg for MAC: Venter
- Måtte redigere en linje i luaconf.h for å eksportere dll riktig. -- dette er en hard prosjektavhengighet som må skriptes i byggingen.
- Antar at liblua.so vil trenge de samme omarbeidingene når vi kommer til Linux-plattformen.
- Kjør kommandoen på Windows fra prj-roten: "dart run bin/main.dart"



What the UI syntax looks like: 
```
app = FlutterApp()

app.page:add(
  Column {
    Text("Hello, Lua!"),
    Button("Click me", on_click = function()
      print("Button clicked!")
    end)
  }
)

app:run()


Vs Native flutter: 
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Lua App',
      home: HelloLuaWidget(),
    );
  }
}

class HelloLuaWidget extends StatefulWidget {
  @override
  _HelloLuaWidgetState createState() => _HelloLuaWidgetState();
}

class _HelloLuaWidgetState extends State<HelloLuaWidget> {
  void _handleButtonClick() {
    print("button clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello Lua')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello, lua'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleButtonClick,
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}
```