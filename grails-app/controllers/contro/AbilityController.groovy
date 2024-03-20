package contro

import grails.converters.JSON

class AbilityController {

    def abilityModelService;

    def apilistabilities= {
        def results = Ability.list().sort{ it.name }
        println results
        render results as JSON
    }

    def apismallabilitylist = {
        def results = Ability.list().sort{ it.name }
        [abilities:results]
    }

    def apigetabilitytimings = {
        println ("AbilContr: "+params)
        println ("       id: "+params.ability)
        def x = JSON.parse(params.ability)
        println ("Object   : "+x)
        def abil = Ability.get(x.id)
        def timedAbilities = TimedAbility.findAllByAbility(abil)
        println (timedAbilities)
        render timedAbilities as JSON
    }

    def index(Integer max) {
        redirect(action: 'list', params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        println '++++++++++++++++++++++++++'
        [abilityInstanceList: Ability.list().sort { it.name }]
    }

    def saveAbility = {
        println params
        Ability ability = abilityModelService.saveAbility(params.abilityform)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ability.label', default: 'Ability'), ability.description])}"
        flash.textClass = 'text-success'
        redirect action:'list'
    }

    def execute = {
        GroovyShell shell = new GroovyShell(this.class.classLoader)
        println params
        Ability ability = Ability.get(params.id)
        println ability.processingScript
        shell.evaluate(ability.processingScript)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ability.label', default: 'Ability'), ability.description])}"
        flash.textClass = 'text-success'
        redirect action:'list'
    }

    def create = {
        Ability abilityInstance = new Ability()
        abilityInstance.properties = params
        def processorList = Processor.list().sort { it.name }
        println "test the west"
        println processorList
        render (view:'edit', model: [abilityInstance: abilityInstance, processorList:processorList])
    }

    def edit = {
        Ability abilityInstance = Ability.get(params.id)
        def processorList = Processor.list().sort { it.name }
        println "test the west"
        println processorList
        return [abilityInstance: abilityInstance, processorList:processorList]
    }

    def delete = {
        //Ability abilityInstance = Ability.get(params.id)
        abilityModelService.delete(params.id)
        redirect action:'list'
    }

}
