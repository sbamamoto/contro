package contro

import grails.gorm.transactions.Transactional

@Transactional
class ScriptExecutorService {

    def static runScript( Processor processor, Map params ) {
        GroovyShell shell = new GroovyShell(/*this.class.classLoader*/)
        String script = processor.processingScript
        params.each { k, v ->
            script = 'def ' + k + '=' + '"' + v + '"' + '\n' +script
        }
        // println script
        shell.evaluate(script)
    }

}
