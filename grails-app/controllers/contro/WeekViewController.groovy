package contro

class WeekViewController {

    def checkTiming (index, timing, device, week) {
        def times = timing.timing.split(":")
        def hour = times[0].toInteger()
        if (week[index]==null){ //init dayofweek with empty map
            week[index]=[:]
        }
        if (week[index][hour]==null) {
            week[index][hour]=[]  //init timeslot with empty list
        }
        
        if (timing.dimmValue.trim().equals("150")) {
            week[index][hour].add(["ON  "+device.description, "deviceon", device.id])
        }
        else {
            week[index][hour].add(["OFF "+device.description, "deviceoff",device.id])
        }
        return week
    }
    
    def index() { 
        def devices=Device.list()
        def week = [:]
        devices.each() { device ->
            device.timings.each{ timing ->
                print timing?.timing  
                def index=0;
                if (timing.monday) {
                    week = checkTiming(0, timing, device, week)
                }
                if (timing.tuesday) {
                    week = checkTiming(1, timing, device, week)
                }
                if (timing.wednesday) {
                    week = checkTiming(2, timing, device, week)
                }
                if (timing.thursday) {
                    week = checkTiming(3, timing, device, week)
                }
                if (timing.friday) {
                    week = checkTiming(4, timing, device, week)
                }
                if (timing.saturday) {
                    week = checkTiming(5, timing, device, week)
                }
                if (timing.sunday) {
                    week = checkTiming(6, timing, device, week)
                }

                
            }            
        }
        [week:week]
    }
}
