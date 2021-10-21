//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import Foundation
import StreamChat
import SwiftUI

/// Factory used to create views.
public protocol ViewFactory: AnyObject {
    var chatClient: ChatClient { get }
    
    associatedtype NoChannels: View
    /// Creates the view that is displayed when there are no channels available.
    func makeNoChannelsView() -> NoChannels
    
    associatedtype ChannelDestination: View
    func makeDefaultChannelDestination() -> (ChatChannel) -> ChannelDestination
    
    associatedtype LoadingContent: View
    func makeLoadingView() -> LoadingContent
}

/// Default implementations for the `ViewFactory`.
extension ViewFactory {
    public func makeNoChannelsView() -> NoChannelsView {
        NoChannelsView()
    }
    
    public func makeDefaultChannelDestination() -> (ChatChannel) -> ChatChannelView<Self> {
        { [unowned self] channel in
            ChatChannelView(viewFactory: self, channel: channel)
        }
    }
    
    public func makeLoadingView() -> LoadingView {
        LoadingView()
    }
}

/// Default class conforming to `ViewFactory`, used throughout the SDK.
public class DefaultViewFactory: ViewFactory {
    @Injected(\.chatClient) public var chatClient
    
    private init() {}
    
    public static let shared = DefaultViewFactory()
}
