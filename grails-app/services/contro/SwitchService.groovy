package contro

import grails.transaction.Transactional

@Transactional
class SwitchService {

    def device(String id, String state) {
        try {
            def url = "http://localhost/home/switchDevice.py?Helligkeit="+
            state+"&device="+id
            print url
            URL u = new URL(url);
            InputStream is = u.openStream();
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String theLine;
            while ((theLine = br.readLine()) != null) {
                System.out.println(theLine);
            }
        }
        catch (MalformedURLException ex) {
            System.err.println("Switch Service: "+ex);
        }
        catch (IOException ex) {
            System.err.println("Switch Service: "+ex);
        }
    }
}
