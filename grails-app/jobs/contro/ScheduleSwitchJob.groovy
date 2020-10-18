package contro

import java.util.Date;
import java.util.Calendar;
import contro.Setting

class ScheduleSwitchJob {
    def timeout = 30000l // execute job once in 30 seconds

    static triggers = {
        simple repeatCount: 0 // execute job once in 5 seconds
        cron cronExpression: '0 */1 * * * ?'
    }
    
    def runcgi(url) {

        try {
            URL u = new URL(url);
            HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();            
            InputStream is = u.openStream();            
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String theLine;
            while ((theLine = br.readLine()) != null) {
                if (connection.getResponseCode() > 200) {
                    System.out.println(theLine);
                }
            }
        }
        catch (MalformedURLException ex) {
            System.err.println(ex);
        }
        catch (IOException ex) {
            System.err.println(ex);
        }
    }

    def executeAbility() {

    }


    def switchIt(device,timing,now) {
        Calendar cal = Calendar.getInstance();
        def dow = cal.get(Calendar.DAY_OF_WEEK)
        def rightDay = timing.sunday && dow==Calendar.SUNDAY ||
        timing.monday && dow==Calendar.MONDAY ||
        timing.tuesday && dow==Calendar.TUESDAY ||
        timing.wednesday && dow==Calendar.WEDNESDAY ||
        timing.thursday && dow==Calendar.THURSDAY ||
        timing.friday && dow==Calendar.FRIDAY ||
        timing.saturday && dow==Calendar.SATURDAY
        def timeArray = timing.timing.split(":")
        //        if (rightDay) {
        //            System.out.println("    NOW:"+now.getHours()+":"+now.getMinutes()+ "   DOW:"+cal.get(Calendar.DAY_OF_WEEK))
        //            System.out.println("    RUN:"+timing.timing)
        //        }
        if (rightDay && now.getMinutes()==Integer.parseInt(timeArray[1]) &&
            now.getHours()==Integer.parseInt(timeArray[0])) {
            if (!timing.power){
                //System.out.println("    Switching OFF required")
                Device.withTransaction {
                    def dbdevice=Device.findById(device.id)
                    dbdevice.state = "OFF"
                    dbdevice.dimm ="0"

                    if ( !dbdevice.save()) {
                        dbdevice.errors.allErrors.each{println it.defaultMessage}
                    }
                }
                def url = device.controller.url
                    .replace("#address#", device.device)
                    .replace("#brightness#", timing.dimmValue)

                if (device.channel) {
                    url = url.replace("#channel#", device.channel)
                }
                device.power = true
                device.save()
                Thread.sleep(500)
                runcgi(url)
            }
            else {
                //System.out.println("    Switching ON required")
                Device.withTransaction {
                    def dbdevice=Device.findById(device.id)
                    dbdevice.state = "ON"
                    if (dbdevice.canDimm) {
                        dbdevice.dimm = timing.dimmValue
                    }
                    else {
                        dbdevice.dimm = "150"
                    }
                    if ( !dbdevice.save()) {
                        dbdevice.errors.allErrors.each{println it.defaultMessage}
                    }
                }
                Thread.sleep(500)
                def url = device.controller.url
                    .replace("#address#", device.device)
                    .replace("#brightness#", timing.dimmValue)
                
                if (device.channel) {
                    url = url.replace("#channel#", device.channel)
                }                    
                device.power = false
                device.save()
                runcgi(url)
            }

        }
    }

    
    def execute() {
        System.out.println ("Timer running")
        def mode = Setting.findBySetting('partymode')
        System.out.println ("Timer running. PartyMode is: "+mode?.value)
        if (mode?.value=="OFF") {
            List devices = Device.list()
            Date now = new Date();
        
            devices.each { device ->
                System.out.println (device.description+" "+device.state+"  ("+device.device+")")
                device.timedAbilities.each{switchIt(device,it,now)}
            }
        }
    }
}
