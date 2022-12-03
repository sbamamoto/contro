package contro

import grails.gorm.transactions.Transactional

@Transactional
class GlobalModelService {
    
    Boolean addGlobalToList(String key, String value, String type, Date date) {
        Boolean result = false
        if (!key.startsWith('$')) {
            Globals global = new Globals()
            global.key = '$' + key
            global.value = value
            global.type = type
            global.date = date
            global.save(flush:true, failOnError:true)
        }
        return result
    }

    /**
      * Adds one key value pair to the global store.
      * Returns false if the key already exists.
    ***/

    Boolean addGlobal(String key, String value, String type, Date date) {
        Globals global = Globals.findByKey(key)
        Boolean result = false
        if (!global && !key.startsWith('$')) {
            global = new Globals()
            global.key = key
            global.value = value
            global.type = type
            global.date = date
            result = global.save(flush:true)
        }
        else {
            result = false
        }

        return result
    }

    Boolean exists(String key) {
        return Globals.findByKey (key) != null || Globals.findByKey('$' + key) != null
    }

    Boolean updateGlobal(String key, String value, String type, Date date) {
        Globals global = Globals.findByKey(key)
        Boolean result = false
        if (global && !key.startsWith('$')) {
            global.key = key
            global.value = value
            global.type = type
            global.date = date
            result = global.save(flush:true)
        }
        else {
            result = false
        }

        return result
    }

    Boolean removeGlobal(String key) {
        Globals global = Globals.findByKey(key)
        Boolean result = true
        if (global) {
            result = global.delete()
        }
        return result
    }

    String getGlobalValue(String key) {
        Globals global = Globals.findByKey(key)
        return global?.value
    }

    List getGlobalList(String key) {
        def globals = Globals.findAllByKey('$'+key)
        List<Globals> list = []
        globals.each {
            list.add (it)
        }
        return list
    }

}