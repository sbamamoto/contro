package contro

class DeviceType {

    String description
    String name
    String guiController

    static hasMany = [
        abilities: Ability
    ]

    static constraints = {
        guiController(nullable:true)
    }
    
    static mapping = {
        id(generator: 'org.hibernate.id.enhanced.SequenceStyleGenerator', 
            params: [sequence_name: 'start_seq', initial_value: 100])
    }
}
