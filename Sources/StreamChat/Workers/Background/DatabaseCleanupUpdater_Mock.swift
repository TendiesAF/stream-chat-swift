//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

@testable
import StreamChat

final class DatabaseCleanupUpdater_Mock: DatabaseCleanupUpdater {
    var resetExistingChannelsData_body: (DatabaseSession) -> Void = { _ in }
    override func resetExistingChannelsData(session: DatabaseSession) {
        resetExistingChannelsData_body(session)
    }

    var refetchExistingChannelListQueries_body: () -> Void = {}
    override func refetchExistingChannelListQueries() {
        refetchExistingChannelListQueries_body()
    }
    
    var syncChannelListQueries_syncedChannelIDs: Set<ChannelId>?
    var syncChannelListQueries_completion: ((Result<Void, Error>) -> Void)?
    override func syncChannelListQueries(
        syncedChannelIDs: Set<ChannelId>,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        syncChannelListQueries_syncedChannelIDs = syncedChannelIDs
        syncChannelListQueries_completion = completion
    }
}
