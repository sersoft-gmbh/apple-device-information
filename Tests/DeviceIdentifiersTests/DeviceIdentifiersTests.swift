import XCTest
@testable import DeviceIdentifiers

final class DeviceInfoTests: XCTestCase {
    func testCurrentDeviceInfo() {
        let deviceInfo = DeviceInfo.current
        XCTAssertEqual(deviceInfo.identifier, _currentDeviceIdentifier())
        XCTAssertEqual(deviceInfo.name, _currentDeviceName())
        XCTAssertEqual(deviceInfo.id, deviceInfo.identifier)
    }
}
