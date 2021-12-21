//
//  ContentView.swift
//  CrashExample
//
//  Created by Gong Zhang on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            // 💥 crash: iOS 14 + release build + xcode 13.2.1
            if #available(iOS 15.0, *) {
                Text("iOS 15 is fine")
                    .badge(1) // use any iOS-15-specific API
            }
            
            #if DEBUG
            Text("This example won't crash in debug build. Please rebuild with **release** configuration.")
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
