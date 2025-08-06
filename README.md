

The idea:

A dart framework that allows me to spin up my typical development workflow using Lua as the scripting language. 

I'd like the following capabilities: 
- Ability to spin up http and TCP server's / clients with Node express like syntax using Lua  (so basically a routing framework mapped to dart)
- A PostgreSQL client in lua that maps to a dart postgreSQL client. Keeping the syntax similar to Node style things like the express feature prevously mentioned. 
- Expandability - Goal is to start adding other features and capabilities as we get going. 

Does this make sense to you? I dont think we should use dart_dardo. I think we'd get the desired result using FFI to map things. If you're following lets sketch up a diagram and road map to add to my readme


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

 Shared Goals:
 • Node-like DX (developer experience) and API ergonomics  
 • Layered architecture for scalability  
 • Tight client-server parity between Dart and Lua  

 ✅ Phase 1: Core MVP
- [x] Lua HTTP Server using native http and route dispatcher
- [x] Dart client abstraction with matching route and method structure
- [x] Basic FFI bridge between Dart and Lua for server lifecycle and calls
🔄 Phase 2: PostgreSQL Integration
- [ ] Lua PostgreSQL wrapper (Node-style: pg.connect(), query())
- [ ] Dart PostgreSQL layer with same method names
- [ ] Shared query builder module
🔁 Phase 3: TCP Support & Expansion Hooks
- [ ] Lua TCP server/client API (basic socket IO, framed messages)
- [ ] Dart TCP abstraction layer
- [ ] Expansion interface: register plugins/modules
📈 Phase 4: Developer Experience
- [ ] CLI scaffold: dart run create myservice
- [ ] Hot reload/Live reload from Dart side
- [ ] Diagnostics & logging from both ends
🔮 Phase 5: Ecosystem & Add-ons
- [ ] Auth middleware in Lua (e.g. JWT)
- [ ] Analytics layer (Dart frontend logging to Lua)
- [ ] Plugin registry


your_dart_project/
├── bin/
│   └── main.dart          ← CLI entry point
├── lib/
│   └── lua_bindings.dart  ← FFI bindings and reusable logic
├── native/
│   ├── linux/
│   │   └── liblua.so
│   └── windows/
│       └── lua.dll
├── pubspec.yaml

Notes from building: 
- Download lua 5.1.5 source
{ Will error from multiple linked main() clean that up to continue - }
- Build lualib.so with make / GCC { This is linux / android only }
- Build lua.dll { built using developer powershell for vs 2022 }
- Build for MAC: Pending
- Had to edit a line in luaconf.h to export dll properly. -- this is a hard project dependency that will need to be scripted in the build.
- Assumes the liblua.so will need the same re-works once we hit the linux platform.
- Run command on windows from prj root: "dart run bin/main.dart"