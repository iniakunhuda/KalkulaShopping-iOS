//
//  KalkulaShoppingApp.swift
//  KalkulaShopping
//
//  Created by Miftahul Huda on 28/04/22.
//

import SwiftUI

// https://www.youtube.com/watch?v=i66xMrpIgYA&ab_channel=JamesHaville
// https://www.youtube.com/watch?v=uQtM6StTsQg&ab_channel=LoganKoshenka

@main
struct KalkulaShoppingApp: App {
    
    @StateObject var modelData: ModelData = ModelData()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(modelData)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
