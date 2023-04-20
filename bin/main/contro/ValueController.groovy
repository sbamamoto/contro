package contro

class ValueController {

    def valueModelService
    
    def index() {
        if (params.id) {
            Device dev = Device.get(params.id)

            def values = dev.values
            values.each {
                def list = Processor.findAllByEventKeyAndEventAddress(it.key, it.channel)
                println ('Device: '+dev.description+' has '+list.size+' observers');
            }

            if (dev) {
                println("++++++++++++++++++++++++"+dev)
                [device:dev, values:dev.values.sort { it.channel }]
            }
            else {
                redirect(controller: 'device')
            }
        }
        else {
            redirect(controller: 'device')
        }
    }
    
    def edit() {
        def value = Value.findByKeyAndChannel(params.id,params.channel)
        if (value == null) {
            value = new Value()
        }
        [device:Device.get(params.deviceId),valueInstance:value]
    }

    def delete () {
        println (">>>>>>>>>>>>>>>> "+params)
        valueModelService.deleteValue(params.id, params.deviceId)
        redirect (action:"index", params:["id":params.deviceId])
    }
    
    
    def save = {
        def value
        println params
        value = valueModelService.saveValue(params)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'value.label', default: 'Wert '), value.key])}"
        flash.textClass="text-success"
        redirect (action:"index", params:["id":params.deviceId])
    }
    
}
