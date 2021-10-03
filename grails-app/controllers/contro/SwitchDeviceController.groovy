package contro

class SwitchDeviceController {

    def deviceModelService
    def scriptExecutorService
    //def switchService

    def runcgi(url) {
        println ('URL: ' + url)
        try {
            URL u = new URL(url)
            InputStream is = u.openStream()
            InputStreamReader isr = new InputStreamReader(is)
            BufferedReader br = new BufferedReader(isr)
            String theLine
            while ((theLine = br.readLine()) != null) {
                println(theLine)
            }
        }
        catch (MalformedURLException ex) {
            println(ex)
        }
        catch (IOException ex) {
            println(ex)
        }
    }

    def switchDevice = {
        Ability ability = Ability.get(params.ability)
        println "##################################################################"
        println params
        
        String state = scriptExecutorService.runScript(ability.processor, params)
        Device dev
        if (params.channel) {
            dev = Device.findByDeviceAndChannel(params.address, params.channel)
        }
        else {
            dev = Device.findByDevice(params.address)
        }
        deviceModelService.setState(dev, state)

        redirect (controller:'tablet')
    }

    def setValue = {
    }

    def switchRoom = {
        def room = Room.get(params.room)

        room.devices.each {
            if (params.state.toInteger() > 0) {
                it.state = 'ON'
            }
            else {
                it.state = 'OFF'
            }
            it.save()

            def url = it.controller.url
                .replace('#address#', it.device)
                .replace('#brightness#', it.state)

            runcgi(url)
            Thread.sleep(500)
        }
        redirect (controller:'tablet')
    }

    def switchAll = {
        def room = Room.list()

        room.each {
            it.devices.each {
                if (params.state.toInteger() > 0) {
                    it.state = 'ON'
                }
                else {
                    it.state = 'OFF'
                }
                it.save()
                def url = it.controller.url
                .replace('#address#', it.device)
                .replace('#brightness#', it.state)

                switchService.httpSwitch(url)
                Thread.sleep(500)
            }
        }
        redirect (controller:'tablet')
    }

}
