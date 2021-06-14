package contro

class SettingController {

    def index() { 
        [settings: Setting.list()]
    }

    def list() { 
        [settings: Setting.list()]
    }

}
