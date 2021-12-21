# swiftui-availability-check-crash

This is a sample project that demonstrates a crash about SwiftUI availability check in Xcode 13.2.1.

The simple code below always crashes on **iOS 14.x** if you build your project with **Release** configuration in **Xcode 13.2.1**.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            // 💥 crash: iOS 14 + release build + xcode 13.2.1
            if #available(iOS 15.0, *) {
                Text("iOS 15 is fine")
                    .badge(1) // use any iOS-15-specific API
            }
        }
    }
}
```

The crash log may like this:

```log
OS Version:          iPhone OS 14.8.1 (18H107)
Release Type:        User
Baseband Version:    n/a
Report Version:      104

Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
Exception Subtype: KERN_INVALID_ADDRESS at 0x0000000000000000
VM Region Info: 0 is not in any region.  Bytes before following region: 4328914944
...

Termination Signal: Segmentation fault: 11
Termination Reason: Namespace SIGNAL, Code 0xb
Terminating Process: exc handler [54802]
Triggered by Thread:  0

Thread 0 name:
Thread 0 Crashed:
0   libswiftCore.dylib            	0x00000001b0a74750 swift::ResolveAsSymbolicReference::operator()(swift::Demangle::__runtime::SymbolicReferenceKind, swift::Demangle::__runtime::Directness, int, void const*) + 124 (MetadataValues.h:1263)
1   libswiftCore.dylib            	0x00000001b0a96018 swift::Demangle::__runtime::Demangler::demangleSymbolicReference(unsigned char) + 212 (functional:1880)
2   libswiftCore.dylib            	0x00000001b0a92d04 swift::Demangle::__runtime::Demangler::demangleType(__swift::__runtime::llvm::StringRef, std::__1::function<swift::Demangle::__runtime::Node* (swift::Demangle::__runtime::SymbolicReferenceKind, swi... + 200 (Demangler.cpp:589)
3   libswiftCore.dylib            	0x00000001b0a7a660 swift_getTypeByMangledNameImpl(swift::MetadataRequest, __swift::__runtime::llvm::StringRef, void const* const*, std::__1::function<swift::TargetMetadata<swift::InProcess> const* (unsigned int, unsi... + 496 (MetadataLookup.cpp:69)
4   libswiftCore.dylib            	0x00000001b0a77ab0 swift::swift_getTypeByMangledName(swift::MetadataRequest, __swift::__runtime::llvm::StringRef, void const* const*, std::__1::function<swift::TargetMetadata<swift::InProcess> const* (unsigned int, u... + 604 (CompatibilityOverride.def:153)
...
```

Below is a clumsy workaround that prevents the crash on iOS 14.

```swift
if #available(iOS 15.0, *) {
    Group {
        if #available(iOS 15.0, *) {
            Text("Hello").badge(1)
        }
    }
}
```
