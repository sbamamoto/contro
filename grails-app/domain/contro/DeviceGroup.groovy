package contro

class DeviceGroup {
    String name
    
    static hasMany = [
        devices : Device
    ]
    
    static constraints = {
    }
}
