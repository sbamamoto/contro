package contro

class GlobalsController {

    def index() {
        def criteria = Globals.createCriteria()
        def values = criteria.listDistinct {
            projections {
                groupProperty('key')
            }
        }
        [globals:values]
    }

    def list = {
        def globals = Globals.findAllByKey(params.id)
        globals.sort{it.date}
        [key:params.id, globals:globals]
    }
    
    def download = {
        def globals = Globals.findAllByKey(params.id)
        StringBuilder result = new StringBuilder()
        globals.each {
            result.append (it.key)
            result.append (',')
            result.append (it.value)
            result.append (',')
            result.append (it.type)
            result.append (',')
            result.append (it.date)
            result.append ('\n')
        }
        render(text:result, contentType:'text/csv')
    }
}
