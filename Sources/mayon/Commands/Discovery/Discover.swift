//
//  Discover.swift
//  Mayon
//
//  Created by Roshan Nindrai on 5/25/17.
//
//

import Foundation
import SwiftCLI
import MayonFramework

/// Command that helps to list all devices that are connected to the machine
final class Discover {

    /// The name of the command; used to route arguments to commands
    var name: String {
        return "discover"
    }

    /// A short description of the Discovery Command
    var shortDescription: String {
        return "List all the devices both android and iOS that are connected"
    }

    let iOS = Flag("-i", "--ios", usage: "Search for connected iOS devices")
    let android = Flag("-a", "--android", usage: "Search for connected Android devices")

    var optionGroups: [OptionGroup] {
        let osType = OptionGroup(options: [iOS, android], restriction: .atMostOne)
        return [osType]
    }

}

// MARK: - Command conformance
extension Discover: Command {

    /// Returns requested platform type from flags
    var platform: Platform {
        if iOS.value {
            return Platform.iOS
        } else if android.value {
            return Platform.android
        } else {
            return Platform.default
        }
    }

    /// Executes the command
    ///
    /// - Throws: CLIError if command cannot execute successfully
    func execute() throws {
        let discoveryOption = DiscoveryOption(platform: platform)
        let discovery = Discovery(discoveryOption)
        print(discovery.run())
    }

}
