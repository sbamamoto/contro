package contro

class Remote {
    String name
    String description
    String type

    static hasMany = [        
        remoteControls : RemoteControl
    ]

    static constraints = {
        description (nullable:true)
        type (nullable:true)
    }

}
