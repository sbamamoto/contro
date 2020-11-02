package contro

class Timing {

    boolean power
    boolean ramp
    String timing
    String dimmValue
    String description
    boolean monday
    boolean tuesday
    boolean wednesday
    boolean thursday
    boolean friday
    boolean saturday
    boolean sunday
    Ability ability
    Processor processor

    static constraints = {
         power(nullable:true)
         ramp(nullable:true)
         timing(nullable:true)
         dimmValue(nullable:true)
         description(nullable:true)
         monday(nullable:true)
         tuesday(nullable:true)
         wednesday(nullable:true)
         thursday(nullable:true)
         friday(nullable:true)
         saturday(nullable:true)
         sunday(nullable:true)
         processor(nullable:true)
         ability(nullabel:true)
    }

    String toString() {
        return timing + " - " + description
    }
}
