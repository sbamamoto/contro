package contro

import contro.Setting

class PartymodeController {

    def settingsModelService

    def index() { 
        def mode = Setting.findBySetting("partymode")?.value?:'OFF'
        [mode:mode]
    }
    
    def switchMode() {
        settingsModelService.setBoolean('partymode', params.state)
    }
}
