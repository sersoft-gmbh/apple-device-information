import XCTest
import Sysctl
@testable import DeviceInformation
#if arch(arm64) || arch(x86_64)
#if canImport(Combine) && canImport(SwiftUI)
import Combine
import SwiftUI
#endif
#endif

final class DeviceInfoTests: XCTestCase {
    func testCurrentDeviceInfo() {
        let deviceInfo = DeviceInfo.current
#if os(macOS) || targetEnvironment(macCatalyst)
        XCTAssertEqual(deviceInfo.identifier, SystemControl().hardware.model)
#else
        XCTAssertEqual(deviceInfo.identifier, SystemControl().hardware.machine)
#endif
        XCTAssertEqual(deviceInfo.id, deviceInfo.identifier)
        XCTAssertEqual(deviceInfo.name,
                       DeviceInfo._deviceIdentifierToNameMapping[deviceInfo.identifier])
        XCTAssertEqual(deviceInfo.operatingSystem.name, DeviceInfo.OperatingSystem.currentName())
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        XCTAssertEqual(deviceInfo.operatingSystem.version,
                       "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)")
        XCTAssertEqual(deviceInfo.operatingSystem.build, SystemControl().kernel.osBuild)
    }

#if arch(arm64) || arch(x86_64)
#if canImport(Combine) && canImport(SwiftUI)
    func testSwiftUIEnvironment() throws {
        guard #available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
        else { throw XCTSkip() }
        XCTAssertEqual(EnvironmentValues().deviceInfo, .current)
    }
#endif
#endif
}
