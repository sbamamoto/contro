package contro

class Device {
    boolean canDimm
    String description
    String device
    String state = 'OFF'
    String dimm = '0'
    Interface controller
    String channel
    
    static hasMany = [
        timings : Timing
    ]
    static constraints = {
     canDimm(nullable:false)
     device(nullable:false)
     description(nullable:false)
     state(nullable:false)
     dimm(nullable:false)
     channel(nullable:true)
    }

    def String toString() {
        return description
    }
}
