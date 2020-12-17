package contro

import java.util.Date;
import java.util.Calendar;
import contro.Setting

class ScheduleSwitchJob {
    def timeout = 30000l // execute job once in 30 seconds
    def scriptExecutorService
    def deviceModelService

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

        if (rightDay && now.getMinutes()==Integer.parseInt(timeArray[1]) &&            
            now.getHours()==Integer.parseInt(timeArray[0])) {
            println " %%%%%%%%%%%%%%%  Switching [" + device.device + "] [" + timing.ability.description + "] [" + timing + "]"
            
            Map params = [:]
            params.channel = device.channel
            params.address = device.device
            params.value = timing.dimmValue
            params.url = device.controller.url

            if (device.sessionId) {
                params.sessionId = device.sessionId
            }

            String state = scriptExecutorService.runScript(timing.ability.processor, params)
            deviceModelService.setState(device, state)
        }
    }

    
    def execute() {
        //System.out.println ("Timer running")
        def mode = Setting.findBySetting('partymode')
        //System.out.println ("Timer running. PartyMode is: "+mode?.value)
        if (mode?.value=="OFF") {
            List devices = Device.list()
            Date now = new Date();
        
            devices.each { device ->
                //System.out.println (device.description+" "+device.state+"  ("+device.device+")")
                device.timings.each{switchIt(device,it,now)}
            }
        }
    }
}
