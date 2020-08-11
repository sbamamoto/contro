package contro

import java.text.SimpleDateFormat
import java.time.LocalDateTime
import java.time.ZoneId

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
        
        if (timing.dimmValue?.trim().equals("150")) {
            week[index][hour].add(["ON  "+device.description, "deviceon", device.id])
        }
        else {
            week[index][hour].add(["OFF "+device.description, "deviceoff",device.id])
        }
        return week
    }
    
    
    def changeschedule () {
        print params['deviceid']
        print params['ontimings']
        print params['offtimings']
        print params['oldonid']
        print "oldoffid: "+params['oldoffid']
        print params['removeOn']
        print params['removeOff']
        def device = Device.findById(params['deviceid'])
        if (params['removeOn']=="on" || params['ontimings']!=params['oldonid']) {
            def ontiming = Timing.findById(params['oldonid'])
            if (ontiming != null) {
                device.removeFromTimings(ontiming)
            }
        }
        if (params['removeOff']=="on" || params['offtimings']!=params['oldoffid']) {
            def offtiming = Timing.findById(params['oldoffid'])
            print "timing: "+offtiming
            if (offtiming!=null) {
                device.removeFromTimings(offtiming)
            }
        }
        
        if (params['removeOn']!="on" && params['ontimings']!=params['oldonid']) {
            def ontiming = Timing.findById(params['ontimings'])
            device.addToTimings(ontiming)
        }
        if (params['removeOff']!="on" && params['offtimings']!=params['oldoffid']) {
            def offtiming = Timing.findById(params['offtimings'])
            device.addToTimings(offtiming)
        }
        
        
        redirect (controller:"weekView", action:"deviceTimings", params: [id: params['deviceid']])
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
    
    
    def deviceTimings () {
        def device = Device.findById(params['id'])
        def timings = device.timings.sort(  { a, b -> a.timing <=> b.timing})
        // get Date of this monday
        def today = new GregorianCalendar()
        today.set(Calendar.DAY_OF_WEEK, today.getFirstDayOfWeek());
        print "***************"+today.getTime()
        Date mondayOfWeek = today.getTime()
        def onSchedule = []
        
        def myJson = ""
        def powerOn = ""
        def powerOff = ""
        def offset = 0
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        timings.each {            
            mondayOfWeek = today.getTime()
            if (it.monday) {
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
        //mondayOfWeek = today.getTime()+1
        // LocalDateTime.from(mondayOfWeek.toInstant()).plusDays(1);

        def localDate = LocalDateTime.ofInstant(mondayOfWeek.toInstant(), ZoneId.systemDefault()).plusDays(1)
        mondayOfWeek = java.util.Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant());

        timings.each {
            if (it.tuesday) {
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
        localDate = LocalDateTime.ofInstant(mondayOfWeek.toInstant(), ZoneId.systemDefault()).plusDays(1)
        mondayOfWeek = java.util.Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant());
        timings.each {
            if (it.wednesday) {
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id +"', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
       localDate = LocalDateTime.ofInstant(mondayOfWeek.toInstant(), ZoneId.systemDefault()).plusDays(1)
        mondayOfWeek = java.util.Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant());
        timings.each {
            if (it.thursday) {
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
        localDate = LocalDateTime.ofInstant(mondayOfWeek.toInstant(), ZoneId.systemDefault()).plusDays(1)
        mondayOfWeek = java.util.Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant());
        timings.each {
            if (it.friday) {
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
        
        localDate = LocalDateTime.ofInstant(mondayOfWeek.toInstant(), ZoneId.systemDefault()).plusDays(1)
        mondayOfWeek = java.util.Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant());
        timings.each {
            if (it.saturday) {
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
        
        localDate = LocalDateTime.ofInstant(mondayOfWeek.toInstant(), ZoneId.systemDefault()).plusDays(1)
        mondayOfWeek = java.util.Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant());
        
        timings.each {
            if (it.sunday) {
                print it.description
                // Ein OFF ohne ON ist ein siguöäres Ereignis
                
                if (it.power) {  // Startzeit
                    onSchedule.add(it)
                }
                else if (!it.power && onSchedule.size() == 0) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    myJson = myJson+"{title: '"+it.description+"', start: '" + powerOff +"', end: '"+ powerOff + "', offid: '" + it.id +"', devid: '"+ params['id'] +"'},"
                }
                else if (!it.power) {
                    powerOff = sdf.format(mondayOfWeek)+"T"+it.timing+":00"
                    onSchedule.each { on ->
                        powerOn = sdf.format(mondayOfWeek)+"T"+on.timing+":00"
                        myJson = myJson+"{title: '" + on.description + "', start: '" + powerOn +"', end: '"+ powerOff  + "', onid: '"+ on.id +"', offid: '" + it.id + "', devid: '"+ params['id'] +"'},"
                    }
                    onSchedule = []
                }
            }          
        }
        def date = new Date()
        println myJson
        [events:myJson, date:date, device:device]
    }
}
