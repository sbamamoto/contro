package contro

class DeviceGroup {
    String name
    String description

    static hasMany = [
        devices : Device
    ]
    
    static constraints = {
        description (nullable:true)
    }

}
