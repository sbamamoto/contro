package contro

class Room {
    String name
    
    static hasMany = [
        devices : Device
    ]
    
    static constraints = {
    }
}
