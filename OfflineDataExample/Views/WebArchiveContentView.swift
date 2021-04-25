//
//  Created by Artem Novichkov on 24.04.2021.
//

import SwiftUI
import WebKit

struct WebArchiveContentView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadFileURL(url, allowingReadAccessTo: url)
    }
}
