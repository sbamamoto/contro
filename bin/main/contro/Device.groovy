package contro

class Device {

    boolean canDimm
    boolean power
    String description
    String device
    String state = 'OFF'
    String dimm = '0'
    String maxDimm = '100'
    String minDimm = '0'
    Interface controller
    DeviceType type
    String channel
    String sessionId

    static hasMany = [
        timings : Timing,
        abilities: Ability,
        values: Value
    ]

    static constraints = {
        canDimm(nullable:false)
        device(nullable:false)
        description(nullable:false)
        state(nullable:false)
        dimm(nullable:false)
        channel(nullable:true)
        values(nullable:true)
        sessionId(nullable:true)
    }

    String toString() {
        return description
    }

}
