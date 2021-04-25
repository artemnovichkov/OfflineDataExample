//
//  Created by Artem Novichkov on 24.04.2021.
//

import SwiftUI

extension URL: Identifiable {
    
    public var id: String {
        absoluteString
    }
}
