package contro

import groovy.sql.Sql

class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        Processor p = Processor.get(0)
        if (p == null) {
            def scriptPath = grailsApplication.parentContext.servletContext.getRealPath('/dataloader/load.sql')
            println scriptPath

            String sqlString = new File(scriptPath).text

            Sql sql = Sql.newInstance(grailsApplication.config.dataSource.url, grailsApplication.config.dataSource.username,
            grailsApplication.config.dataSource.password, grailsApplication.config.dataSource.driverClassName)

            sql.execute(sqlString)
        }
    }

    def destroy = {
    }

}
