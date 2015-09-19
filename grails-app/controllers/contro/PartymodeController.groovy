package contro

import contro.Setting

class PartymodeController {

    def index() { 
        def mode = Setting.findBySetting("partymode")?.value?:'OFF'
        [mode:mode]
    }
    
    def switchMode() {
        def mode = Setting.findBySetting("partymode")
        if (!mode) {
            mode = new Setting(setting:'partymode')
        }
        mode.value = params.state
        mode.save(flush:true, failOnError:true)
        redirect (action:"index")
    }
}
