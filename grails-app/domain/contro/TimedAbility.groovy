package contro

class TimedAbility {

    Ability ability

    static hasMany = [
        timings: Timing
    ]

    static constraints = {
         timings(nullable:true)
    }

}
