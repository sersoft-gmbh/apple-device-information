public struct DeviceInfo: Equatable, Identifiable {
    public let identifier: String
    public let name: String?

    @inlinable
    public var id: String { identifier }

    init() {
        identifier = _currentMachineIdentifier()
        name = _currentMachineName(forIdentifier: identifier)
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
