package contro

class SwitchDeviceController {
    def deviceModelService

    def runcgi(url) {
        println ("URL: "+url)
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
        def state = ""

        if (params.state.toInteger() > 0) {
            state="ON"
        }
        else {
            state="OFF"
        }

        def device = deviceModelService.setState(params.id, state)

        def url = device.controller.url
           .replace("#address#", params.device)
            .replace("#brightness#", params.state)

        if (device.channel) {
            url = url.replace("#channel#", device.channel)
        }

        runcgi(url)
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



            def url = it.controller.url
                .replace("#address#", it.device)
                .replace("#brightness#", it.state)

            runcgi(url)
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
                def url = it.controller.url
                .replace("#address#", it.device)
                .replace("#brightness#", it.state)

                runcgi(url)
                Thread.sleep(500);
            }
        }
        redirect (controller:"tablet")
    }
    
}
