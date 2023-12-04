//
//  File 2.swift
//  
//
//  Created by Kauntey Suryawanshi on 29/11/23.
//

import Cocoa
import Markdown

/// Takes image scheme://image-name and converts it to base64 png data
struct LocalImageRewriter: MarkupRewriter {

    /// Converts scheme://<image-name> to URL based on location in bundle
    func visitImage(_ image: Markdown.Image) -> Markup? {
        if let source = image.source, let component = URLComponents(string: source), component.scheme == AppHelp.shared.scheme {
            if let imageName = component.host {
                let img = NSImage(named: .init(imageName))
                let imgData = img!.pngData
                let base64String = imgData!.base64EncodedString()

                var newImage = image
                newImage.source = "data:image/png;base64,\(String(describing: base64String) )"
                return newImage
            }
        }
        return image
    }
}

private extension NSImage {
    var pngData: Data? {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }
        let newRep = NSBitmapImageRep(cgImage: cgImage)
        newRep.size = NSSize(width: 10, height: 10)
        return newRep.representation(using: .png, properties: [:])
    }
}
