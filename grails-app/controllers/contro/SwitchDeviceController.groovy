package contro

class SwitchDeviceController {
    def deviceModelService
    def switchService

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

        Ability ability = Ability.get(params.ability)

        GroovyShell shell = new GroovyShell(this.class.classLoader)
        println params

        String script = ability.processor.processingScript

        params.each { k, v -> 
            script = 'def ' + k + ' = ' + '"' + v + '"' + '\n' + script
        }

        println script

        shell.evaluate(script)

        redirect (controller:'tablet')
    }

    def setValue = {
        
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

                switchService.httpSwitch(url)
                Thread.sleep(500);
            }
        }
        redirect (controller:"tablet")
    }
    


}
