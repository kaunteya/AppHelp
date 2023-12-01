//
//  SwiftUIView.swift
//  
//
//  Created by Kauntey Suryawanshi on 28/11/23.
//

import SwiftUI
import WebKit

struct DetailWebView: NSViewRepresentable {
    let htmlText: String

    func makeNSView(context: Context) -> some NSView {
        let webView = WKWebView()
        if #available(macOS 13.3, *) {
            webView.isInspectable = true
        }

        webView.loadHTMLString(htmlText, baseURL: nil)
        return webView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

#Preview {
    DetailWebView(htmlText: testHTMLContent)
}


fileprivate let testHTMLContent = """
<!DOCTYPE html>
<html>
  <body>
    <h1>Header</h1>
    <h2>Header 2</h2>
    <h3>Header 3</h3>
    <p><em>Emphasized</em> text <strong>strong</strong> <code>inline code</code> <a href="foo">link</a> <img src="foo" title="" />.</p>
    <ul>
      <li>
        <p>this</p>
      </li>
      <li>
        <p>is</p>
      </li>
      <li>
        <p>a</p>
      </li>
      <li>
        <p>list</p>
      </li>
    </ul>
    <ol>
      <li>
        <p>eggs</p>
      </li>
      <li>
        <p>milk</p>
      </li>
    </ol>
    <blockquote>
      <p>BlockQuote</p>
    </blockquote>
    <ol start="2">
      <li>
        <p>flour</p>
      </li>
      <li>
        <p>sugar</p>
      </li>
    </ol>
    <ul>
      <li>
        <input type="checkbox" disabled="" checked="" />
        <p>Combine flour and baking soda.</p>
      </li>
      <li>
        <input type="checkbox" disabled="" />
        <p>Combine sugar and eggs.</p>
      </li>
    </ul>
    <pre><code class="language-swift">func foo() {
            let x = 1
        }
        </code></pre>
    <pre><code>// Is this real code? Or just fantasy?
        </code></pre>
    <p>This is an <a href="topic://autolink">topic://autolink</a>.</p>
    <hr />
    <a href="foo.png">
    An HTML Block.
    </a>
    <p>This is some
    <p>inline html</p>
    .</p>
    <p>line<br />
      break
    </p>
    <p>soft
      break
    </p>
  </body>
</html>
"""

