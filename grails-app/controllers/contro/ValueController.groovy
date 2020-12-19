package contro

class ValueController {

    def index() {
        if (params.id) {
            Device dev = Device.get(params.id)

            def values = dev.values
            values.each {
                def list = Processor.findAllByEventKeyAndEventAddress(it.key, it.channel)
                println ('Device: '+dev.description+' has '+list.size+' observers');
            }

            if (dev) {
                [device:dev, values:dev.values.sort { it.channel }]
            }
            else {
                redirect(controller: 'tablet')
            }
        }
        else {
            redirect(controller: 'tablet')
        }
    }

}
