import WebKit

final class KCScriptMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        print("[KCCapture]", message.body)
    }
}

enum KCWebViewFactory {
    static func make() -> WKWebView {
        let controller = WKUserContentController()

        if let url = Bundle.main.url(forResource: "kc_capture", withExtension: "js"),
           let js = try? String(contentsOf: url) {
            controller.addUserScript(
                WKUserScript(source: js,
                             injectionTime: .atDocumentStart,
                             forMainFrameOnly: false)
            )
        }

        controller.add(KCScriptMessageHandler(), name: "apiCapture")

        let config = WKWebViewConfiguration()
        config.userContentController = controller

        return WKWebView(frame: .zero, configuration: config)
    }
}