package contro

class Ability {

    String name
    String description
    Processor processor
    boolean readOnly

    static constraints = {
    }

    static mapping = {
        readOnly defaultValue: false
    }

}
