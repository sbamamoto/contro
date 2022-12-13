package contro

class Value {

    String key
    String value
    String channel
    Date lastChange

    static constraints = {
        lastChange(nullable:true)
    }
}
