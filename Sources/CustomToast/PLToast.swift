//
//  PLToast.swift
//
//
//  Created by Pushkraj Lanjekar on 26/01/24.
//

import Foundation
import SwiftUI

public enum PLToastStyle {
    case error
    case warning
    case success
    case info
}

public extension PLToastStyle {
    @available(iOS 13.0, *)
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

public struct PLToastView: View {
    
    private var type: PLToastStyle
    private var title: String
    private var message: String
    private var onCancelTapped: (() -> Void)
    
    public init(type: PLToastStyle,
                  title: String,
                  message: String,
                  onCancelTapped: @escaping (() -> Void)) {
        self.type = type
        self.title = title
        self.message = message
        self.onCancelTapped = onCancelTapped
    }
    
    @available(iOS 13.0.0, *)
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(type.themeColor)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            .padding()
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}
