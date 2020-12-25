import Foundation
#if canImport(UIKit)
import class UIKit.UIDevice
#endif
import Sysctl

public struct DeviceInfo: Equatable, Identifiable {
    public struct OperatingSystem: Equatable {
        public let name: String
        public let version: String
        public let build: String

        init() {
            #if canImport(UIKit)
            name = UIDevice.current.systemName
            #elseif os(macOS)
            name = "macOS"
            #elseif os(Linux)
            name = "Linux"
            #elseif os(Windows)
            name = "Windows"
            #endif
            let osVersion = ProcessInfo.processInfo.operatingSystemVersion
            version = "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
            build = SystemControl().kernel.osBuild
        }
    }

    public let identifier: String
    public let name: String?

    public let operatingSystem: OperatingSystem

    @inlinable
    public var id: String { identifier }

    init() {
        identifier = _currentDeviceIdentifier()
        name = _currentDeviceName(forIdentifier: identifier)
        operatingSystem = .init()
    }
}

extension DeviceInfo {
    public static let current = DeviceInfo()
}

#if canImport(SwiftUI)
import SwiftUI

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension DeviceInfo {
    @usableFromInline
    @frozen
    enum EnvKey: EnvironmentKey {
        @usableFromInline
        typealias Value = DeviceInfo

        @inlinable
        static var defaultValue: Value { .current }
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension EnvironmentValues {
    @inlinable
    public var deviceInfo: DeviceInfo { self[DeviceInfo.EnvKey.self] }
}
#endif
