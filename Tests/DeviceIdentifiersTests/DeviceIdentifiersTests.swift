import XCTest
@testable import DeviceIdentifiers

final class DeviceInfoTests: XCTestCase {
    func testCurrentDeviceInfo() {
        let deviceInfo = DeviceInfo.current
        XCTAssertEqual(deviceInfo.identifier, _currentMachineIdentifier())
        XCTAssertEqual(deviceInfo.name, _currentMachineName())
        XCTAssertEqual(deviceInfo.id, deviceInfo.identifier)
    }
}
