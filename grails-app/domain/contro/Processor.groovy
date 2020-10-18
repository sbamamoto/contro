package contro

class Processor {

    String name
    String description
    String processingScript
    String type

    static hasMany = [
        processParams : ProcessParam
    ]

    static constraints = {
    }

    static mapping = {
        id(generator: 'org.hibernate.id.enhanced.SequenceStyleGenerator', params: [sequence_name: 'start_seq', initial_value: 100])
    }

    @Override
    String toString() {
        return name + '(' + type + ')'
    }

}
