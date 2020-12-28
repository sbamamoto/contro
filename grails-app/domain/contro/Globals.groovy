package contro

class Globals {

    String key
    String value
    String type
    Date date
    static constraints = {
        value (nullable:true)
        type (nullable:true)
        date (nullable:true)
    }

}
