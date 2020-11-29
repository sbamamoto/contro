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
                System.out.println(theLine)
                result += theLine+"\n"
            }
            return result
        }
        catch (MalformedURLException ex) {
            System.err.println("Switch Service: " + ex)
        }
        catch (IOException ex) {
            System.err.println("Switch Service: "+ex)
        }
        return ""
    }

}
