package contro

class ScriptExecutorService {

    static Map <Long,Script> parsed = [:]

    Script parseScript (Processor processor) {
        String scriptCode = processor.processingScript
        def shell = new GroovyShell(this.class.classLoader)
        println '   +++ Parsing script code'
        Script script = shell.parse(scriptCode)
        parsed.put (processor.id, script)
        return script
    }

    String runScript( Processor processor, Map params ) {
        Script script
        String scriptCode = processor.processingScript

        if (parsed.get(processor.id) == null) {
            script = parseScript(processor)
            // def shell = new GroovyShell()
            // println '   +++ Parsing script code'
            // script = shell.parse(scriptCode)
            // parsed.put (processor.id, script)
        }
        else {
            println '   +++ Retreiveing parsed script'
            script = parsed.get(processor.id)
        }

        def bindings = new Binding()

        Device dev = Device.findByDevice(params.address)
        println ' ++++  '+dev.sessionId
        if (dev.sessionId) {
            bindings.setVariable('sessionId', dev.sessionId)
        }

        if (dev.state) {
            bindings.setVariable('state', dev.state)
        }
        else {
            bindings.setVariable('state', 'OFF')
        }

        params.each { k, v ->
            println ('   +++ Binding '+k+' : '+v+' added.')
            bindings.setVariable(k, v)
        }

        println scriptCode

        script.setBinding(bindings)
        script.run()
        return bindings.getVariable('state') ? 'ON' : 'OFF'

    }

}
