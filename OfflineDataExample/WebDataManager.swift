//
//  Created by Artem Novichkov on 24.04.2021.
//

import WebKit

final class WebDataManager: NSObject {
    
    enum DataError: Error {
        case noImageData
    }
    
    enum DataType: String,  CaseIterable {
        case snapshot = "Snapshot"
        case pdf = "PDF"
        case webArchive = "Web Archive"
    }
    
    private var type: DataType = .webArchive
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    private var completionHandler: ((Result<Data, Error>) -> Void)?
    
    func createData(url: URL, type: DataType, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        self.type = type
        self.completionHandler = completionHandler
        webView.load(.init(url: url))
    }
}

extension WebDataManager: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        switch type {
        case .snapshot:
            let config = WKSnapshotConfiguration()
            config.rect = .init(origin: .zero, size: webView.scrollView.contentSize)
            webView.takeSnapshot(with: config) { [weak self] image, error in
                if let error = error {
                    self?.completionHandler?(.failure(error))
                    return
                }
                guard let pngData = image?.pngData() else {
                    self?.completionHandler?(.failure(DataError.noImageData))
                    return
                }
                self?.completionHandler?(.success(pngData))
            }
        case .pdf:
            let config = WKPDFConfiguration()
            config.rect = .init(origin: .zero, size: webView.scrollView.contentSize)
            webView.createPDF(configuration: config) { [weak self] result in
                self?.completionHandler?(result)
            }
        case .webArchive:
            webView.createWebArchiveData { [weak self] result in
                self?.completionHandler?(result)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        completionHandler?(.failure(error))
    }
}
