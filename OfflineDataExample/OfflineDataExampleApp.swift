//
//  Created by Artem Novichkov on 24.04.2021.
//

import SwiftUI

@main
struct WebArchiveExampleApp: App {
    var body: some Scene {
        UITextField.appearance().clearButtonMode = .whileEditing
        return WindowGroup {
            ContentView()
        }
    }
}
