package contro

class DeviceType {

    String description
    String name

    static hasMany = [
        abilities: Ability
    ]

    static constraints = {
    }
}
