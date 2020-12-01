package contro

class SwitchDeviceController {

    def deviceModelService
    def switchService

    def runcgi(url) {
        println ('URL: ' + url)
        try {
            URL u = new URL(url)
            InputStream is = u.openStream()
            InputStreamReader isr = new InputStreamReader(is)
            BufferedReader br = new BufferedReader(isr)
            String theLine
            while ((theLine = br.readLine()) != null) {
                System.out.println(theLine)
            }
        }
        catch (MalformedURLException ex) {
            System.err.println(ex)
        }
        catch (IOException ex) {
            System.err.println(ex)
        }
    }

    def switchDevice = {
        Ability ability = Ability.get(params.ability)
        Binding binding = new Binding()
        GroovyShell shell = new GroovyShell(this.class.classLoader, binding)
        println params
        String script = ability.processor.processingScript
        Device dev = Device.findByDevice(params.address)
        println " ++++  "+dev.sessionId
        if (dev.sessionId) {
            script = 'def sessionId = "' + dev.sessionId + '"\n' + script
        }

        params.each { k, v ->
            script = 'def ' + k + ' = ' + '"' + v + '"' + '\n' + script
        }

        script = 'def ' + ability.parameter + '\n' + script

        println script
        shell.evaluate(script)
        if (binding.hasVariable('state')) {
          println ( ' ###################### state:' + binding.getVariable('state') )
          
          deviceModelService.setState( dev.id, binding.getVariable('state') )
        }
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
