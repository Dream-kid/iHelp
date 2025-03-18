//
//  AsyncImageView.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 1/15/24.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    let placeholder: Image
    var frameSize: CGFloat
    var aspectRatio: CGFloat
    var contentMode: ContentMode

    init(url: URL?, placeholder: Image = Image(systemName: "photo"), frameSize: CGFloat = 100, aspectRatio: CGFloat = 1, contentMode: ContentMode = .fill) {
        _loader = StateObject(wrappedValue: ImageLoader())
        self.placeholder = placeholder
        self.frameSize = frameSize
        self.aspectRatio = aspectRatio
        self.contentMode = contentMode
        if let url = url {
            loader.loadImage(from: url)
        }
    }

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(aspectRatio, contentMode: contentMode)
                    .clipped()
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(aspectRatio, contentMode: contentMode)
                    .clipped()
            }
        }
        .frame(width: frameSize, height: frameSize)
    }
}
