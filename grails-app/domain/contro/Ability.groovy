package contro

class Ability {

    String name
    String description
    String type
    String identifier
    String parameter
    Processor processor
    boolean readOnly

    static constraints = {
        identifier(nullable:true)
        parameter(nullable:false)
    }

    static mapping = {
        readOnly defaultValue: false
        id(generator: 'org.hibernate.id.enhanced.SequenceStyleGenerator', params: [sequence_name: 'start_seq', initial_value: 100])
    }

}
