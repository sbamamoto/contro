package contro

class RemoteControl {
    String identity
    Device device
    Ability ability     
    // use TOGGLE,SWITCH ON, or SWITCH OFF, DIMM
    String switchMode 
    // value can be ON, OFF, TOGGLE, or a value between 0.0 and 1.0
    String value

    static constraints = {
        device (nullable:true)
        ability (nullable:true)
        switchMode (nullable:true)
        value (nullable:true)
    }
}
