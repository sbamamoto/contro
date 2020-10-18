package contro

class Ability {

    String name
    String description
    String type
    Processor processor
    boolean readOnly

    static constraints = {
    }

    static mapping = {
        readOnly defaultValue: false
        id(generator: 'org.hibernate.id.enhanced.SequenceStyleGenerator', params: [sequence_name: 'start_seq', initial_value: 100])
    }

}
