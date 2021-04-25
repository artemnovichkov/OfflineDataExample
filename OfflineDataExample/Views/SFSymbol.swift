//
//  Created by Artem Novichkov on 24.04.2021.
//

import SwiftUI

enum SFSymbol: String, CaseIterable, View, Identifiable {
    
    case xmark = "xmark"
    
    var id: String {
        rawValue
    }
    
    var body: Image {
        Image(systemName: rawValue)
    }
}

struct SFSymbol_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            ForEach(SFSymbol.allCases) { symbol in
                symbol
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
