package contro

class Device {

    boolean canDimm
    boolean power
    String description
    String device
    String state = 'OFF'
    String dimm = '0'
    Interface controller
    DeviceType type
    String channel

    static hasMany = [
        timedAbilities : TimedAbility,
        abilities: Ability
    ]

    static constraints = {
        canDimm(nullable:false)
        device(nullable:false)
        description(nullable:false)
        state(nullable:false)
        dimm(nullable:false)
        channel(nullable:true)
    }

    String toString() {
        return description
    }

}
