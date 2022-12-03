package contro

class Room {

    String name
    String image
    int showOrder

    static hasMany = [
        devices : Device
    ]

    static mapping = {
        showOrder defaultValue: "0"
    }

    static constraints = {
        image (nullable:true)
    }
}
