package contro

class Remote {
    String name
    String description
    String type
    Processor triggerScript

    static hasMany = [
        remoteControls : RemoteControl
    ]

    static constraints = {
        triggerScript (nullable:true)
        description (nullable:true)
        type (nullable:true)
    }

}
