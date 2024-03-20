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
         monday(nullable:true)
         tuesday(nullable:true)
         wednesday(nullable:true)
         thursday(nullable:true)
         friday(nullable:true)
         saturday(nullable:true)
         sunday(nullable:true)
         processor(nullable:true)
    }

    String toString() {
        String runningDay = ''
        if (monday) {
            runningDay += 'Mo,'
        }
        if (tuesday) {
            runningDay += 'Di,'
        }
        if (wednesday) {
            runningDay += 'Mi,'
        }
        if (thursday) {
            runningDay += 'Do,'
        }
        if (friday) {
            runningDay += 'Fr,'
        }
        if (saturday) {
            runningDay += 'Sa,'
        }
        if (sunday) {
            runningDay += 'So,'
        }

        if (runningDay.length() > 2) {
            runningDay = runningDay[0..-2]
        }
        return timing + " - " + description + " (" + runningDay + ")"
    }
}
