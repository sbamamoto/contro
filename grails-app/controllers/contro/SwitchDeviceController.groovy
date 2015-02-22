package contro

class SwitchDeviceController {
    def runcgi(url) {

        try {
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
            System.err.println(ex);
        }
        catch (IOException ex) {
            System.err.println(ex);
        }
    }
    
    def switchDevice = {
        def device = Device.findByDevice(params.device)
        
        if (params.state.toInteger() > 0) {
            device.state="ON"
        }
        else {
            device.state="OFF"
        }
        device.save()
        runcgi("http://localhost/home/switchDevice.py?Helligkeit="+
            params.state+"&device="+params.device)
        redirect (controller:"tablet")
    }
    
    def switchRoom = {
        def room = Room.get(params.room)
        
        room.devices.each {
            if (params.state.toInteger() > 0) {
                it.state="ON"
            }
            else {
                it.state="OFF"
            }
            it.save()
            runcgi("http://localhost/home/switchDevice.py?Helligkeit="+
                params.state+"&device="+it.device)
            Thread.sleep(500);
        }
        redirect (controller:"tablet")
    }
    
    def switchAll = {
        def room = Room.list()
        
        room.each {
            it.devices.each {
                if (params.state.toInteger() > 0) {
                    it.state="ON"
                }
                else {
                    it.state="OFF"
                }
                it.save()
                runcgi("http://localhost/home/switchDevice.py?Helligkeit="+
                    params.state+"&device="+it.device)
                Thread.sleep(500);
            }
        }
        redirect (controller:"tablet")
    }
    
}
