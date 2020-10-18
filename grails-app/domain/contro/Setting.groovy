package contro

class Setting {
    String setting 
    String value
    
    static constraints = {
    }

    static mapping = {
        id(generator: 'org.hibernate.id.enhanced.SequenceStyleGenerator', params: [sequence_name: 'start_seq', initial_value: 100])
    }

}
