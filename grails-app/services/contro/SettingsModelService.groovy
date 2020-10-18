package contro

import grails.gorm.transactions.Transactional

@Transactional
class SettingsModelService {


    @Transactional
    Setting setBoolean(String key, String value) {
        Setting setting = Setting.findBySetting(key)

        if (!setting) {
            setting = new Setting(setting:key)
        }
        setting.value = value
        setting.save(flush:true, failOnError:true)

        return setting
    }

}
