//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

/// View for the channel list item.
public struct ChatChannelListItem: View {
    @Injected(\.fonts) var fonts
    @Injected(\.colors) var colors
    @Injected(\.utils) var utils
    
    var channel: ChatChannel
    var channelName: String
    var avatar: UIImage
    var onlineIndicatorShown: Bool
    var onItemTap: (ChatChannel) -> Void
    
    public var body: some View {
        Button {
            onItemTap(channel)
        } label: {
            HStack {
                ChannelAvatarView(
                    avatar: avatar,
                    showOnlineIndicator: onlineIndicatorShown
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(channelName)
                        .lineLimit(1)
                        .font(fonts.bodyBold)
                    SubtitleText(text: subtitleText)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    if channel.unreadCount == .noUnread {
                        Spacer()
                    } else {
                        UnreadIndicatorView(
                            unreadCount: channel.unreadCount.messages
                        )
                    }
                    
                    SubtitleText(text: timestampText)
                }
            }
            .padding(.all, 8)
        }
        .foregroundColor(.black)
    }
    
    private var subtitleText: String {
        if let latestMessage = channel.latestMessages.first {
            return "\(latestMessage.author.name ?? latestMessage.author.id): \(latestMessage.textContent ?? latestMessage.text)"
        } else {
            return L10n.Channel.Item.emptyMessages
        }
    }
    
    private var timestampText: String {
        if let lastMessageAt = channel.lastMessageAt {
            return utils.dateFormatter.string(from: lastMessageAt)
        } else {
            return ""
        }
    }
}

/// View for the avatar used in channels (includes online indicator overlay).
public struct ChannelAvatarView: View {
    var avatar: UIImage
    var showOnlineIndicator: Bool
    
    public var body: some View {
        AvatarView(avatar: avatar)
            .overlay(
                showOnlineIndicator ?
                    TopRightView {
                        OnlineIndicatorView()
                    }
                    .offset(x: 3, y: -1)
                    : nil
            )
    }
}

/// View used for the online indicator.
public struct OnlineIndicatorView: View {
    @Injected(\.colors) var colors
    
    private let indicatorSize: CGFloat = 15
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: indicatorSize, height: indicatorSize)
            
            Circle()
                .fill(Color(colors.alternativeActiveTint))
                .frame(width: indicatorSize - 5, height: indicatorSize - 5)
        }
    }
}

/// View displaying the user's unread messages in the channel list item.
public struct UnreadIndicatorView: View {
    @Injected(\.fonts) var fonts
    @Injected(\.colors) var colors
    
    var unreadCount: Int
    
    public var body: some View {
        Text("\(unreadCount)")
            .lineLimit(1)
            .font(fonts.footnoteBold)
            .foregroundColor(Color(colors.staticColorText))
            .frame(width: unreadCount < 10 ? 18 : nil, height: 18)
            .padding(.horizontal, unreadCount < 10 ? 0 : 6)
            .background(Color(colors.alert))
            .cornerRadius(9)
    }
}
