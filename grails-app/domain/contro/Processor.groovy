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

    @Override
    String toString() {
        return name + '(' + type + ')'
    }

}
