package contro

import grails.gorm.transactions.Transactional

@Transactional
class SwitchService {

    static String httpSwitch(String url) {
        try {            
            println url
            URL u = new URL(url)
            InputStream is = u.openStream()
            InputStreamReader isr = new InputStreamReader(is)
            BufferedReader br = new BufferedReader(isr)
            String theLine
            String result = ''
            while ((theLine = br.readLine()) != null) {
                println(theLine)
                result += theLine+"\n"
            }
            return result
        }
        catch (MalformedURLException ex) {
            System.err.println("Switch Service URL Error: " + ex)
        }
        catch (IOException ex) {
            System.err.println("Switch Service IO Error: "+ex)
        }
        return "ERROR"
    }

    static void switchDevice (Device device, value) {

    }

}
