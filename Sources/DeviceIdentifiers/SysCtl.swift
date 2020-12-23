import Darwin

func _sysctl(byName name: String) -> String {
    name.withCString {
        var size = Int()
        sysctlbyname($0, nil, &size, nil, 0)
        let machine = UnsafeMutablePointer<CChar>.allocate(capacity: size)
        defer { machine.deallocate() }
        sysctlbyname($0, machine, &size, nil, 0)
        return String(cString: machine)
    }
}
