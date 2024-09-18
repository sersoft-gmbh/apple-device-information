import Foundation
#if canImport(WatchKit)
import class WatchKit.WKInterfaceDevice
#elseif canImport(UIKit)
import class UIKit.UIDevice
#endif
import Sysctl

/// Contains the information about a device.
public struct DeviceInfo: Sendable, Equatable, Identifiable {
    /// Contains the information about the operating system of a device.
    public struct OperatingSystem: Sendable, Equatable {
        /// The name of the operating system (e.g. iOS or macOS)
        public let name: String
        /// The version of the operating system (e.g. 14.3.0 or 11.0.0)
        public let version: String
        /// The build version of the operating system.
        public let build: String

        static func currentName() -> String {
            // Keep up to date with https://github.com/apple/swift/blob/main/lib/Basic/LangOptions.cpp
#if canImport(WatchKit) // os(watchOS)
            return WKInterfaceDevice.current().systemName
#elseif canImport(UIKit) && !targetEnvironment(macCatalyst) // os(iOS) os(tvOS) os(visionOS)
            @MainActor
            func _access() -> String { UIDevice.current.systemName }
            func _assumeIsolated<T: Sendable>(_ work: @MainActor () -> T) -> T {
#if swift(>=5.10)
                if #available(iOS 13, tvOS 13, *) {
                    return MainActor.assumeIsolated(work)
                }
#else
                if #available(iOS 17, tvOS 17, *) {
                    return MainActor.assumeIsolated(work)
                }
#endif
                return withoutActuallyEscaping(work) {
                    unsafeBitCast($0, to: (() -> T).self)()
                }
            }
            if Thread.isMainThread {
                return _assumeIsolated { _access() }
            } else {
                return DispatchQueue.main.sync { _assumeIsolated { _access() } }
            }
#elseif os(macOS) || targetEnvironment(macCatalyst)
            return "macOS"
#elseif os(Linux)
            return "Linux"
#elseif os(FreeBSD)
            return "FreeBSD"
#elseif os(OpenBSD)
            return "OpenBSD"
#elseif os(Windows)
            return "Windows"
#elseif os(Android)
            return "Android"
#elseif os(PS4)
            return "PS4"
#elseif os(Cygwin)
            return "Cygwin"
#elseif os(Haiku)
            return "Haiku"
#elseif os(WASI)
            return "Web Assembly"
#else
            return "Unknown"
#endif
        }

        init(sysctl: SystemControl) {
            name = OperatingSystem.currentName()
            let osVersion = ProcessInfo.processInfo.operatingSystemVersion
            version = "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
            build = sysctl.kernel.osBuild
        }
    }

    /// The identifier of the device (e.g. iPhone13,4)
    public let identifier: String
    /// The name of the device if present.
    /// If this is nil, please check if a newer version of the package is available.
    public let name: String?
    /// The operating system information.
    public let operatingSystem: OperatingSystem

    @inlinable
    public var id: String { identifier }

    init() {
        let sysctl = SystemControl()
#if os(macOS) || targetEnvironment(macCatalyst)
        identifier = sysctl.hardware.model
#else
        identifier = sysctl.hardware.machine
#endif
        name = DeviceInfo._deviceIdentifierToNameMapping[identifier]
        operatingSystem = .init(sysctl: sysctl)
    }
}

extension DeviceInfo {
    /// The information for the current device.
    public static let current = DeviceInfo()
}

#if arch(arm64) || arch(x86_64)
#if canImport(Combine) && canImport(SwiftUI)
public import SwiftUI

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
extension SwiftUI.EnvironmentValues {
    /// The device info of the current device.
    @inlinable
    public var deviceInfo: DeviceInfo { self[DeviceInfo.EnvKey.self] }
}
#endif
#endif
