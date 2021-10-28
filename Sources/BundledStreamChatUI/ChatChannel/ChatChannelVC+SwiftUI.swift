//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import SwiftUI

@available(iOSApplicationExtension, unavailable)
extension ChatChannelVC: SwiftUIRepresentable {
    public var content: ChatChannelController {
        get {
            channelController
        }
        set {
            channelController = newValue
        }
    }
}
