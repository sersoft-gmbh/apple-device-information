import Foundation
import Testing
import Sysctl
@testable import DeviceInformation
#if canImport(SwiftUI)
import SwiftUI
fileprivate let swiftUIAvailable = true
#else
fileprivate let swiftUIAvailable = false
#endif

@Suite
struct DeviceInfoTests {
    @Test
    func currentDeviceInfo() {
        let deviceInfo = DeviceInfo.current
#if os(macOS) || targetEnvironment(macCatalyst)
        #expect(deviceInfo.identifier == SystemControl().hardware.model)
#else
        #expect(deviceInfo.identifier == SystemControl().hardware.machine)
#endif
        #expect(deviceInfo.id == deviceInfo.identifier)
        #expect(deviceInfo.name == DeviceInfo._deviceIdentifierToNameMapping[deviceInfo.identifier])
        #expect(deviceInfo.operatingSystem.name == DeviceInfo.OperatingSystem.currentName())
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        #expect(deviceInfo.operatingSystem.version == "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)")
        #expect(deviceInfo.operatingSystem.build == SystemControl().kernel.osBuild)
    }

    @Test(.enabled(if: swiftUIAvailable))
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    func swiftUIEnvironment() {
#if canImport(SwiftUI)
        #expect(EnvironmentValues().deviceInfo == .current)
#endif
    }
}
