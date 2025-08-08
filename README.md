```
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

What I expect the UI syntax to look like when complete:
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
