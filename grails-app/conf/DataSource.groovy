dataSource {
        pooled = true
        driverClassName = "org.postgresql.Driver"
        username = "contro"
        password = "contro"
        dialect = net.sf.hibernate.dialect.PostgreSQLDialect
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {     
                        dbCreate = "update" // one of 'create', 'create-drop','update'
                        url = "jdbc:postgresql://mediaserver/contro"
                    
//			dbCreate = "update" // one of 'create', 'create-drop','update'
//			url = "jdbc:h2:file:/opt/dbfiles/testDb"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:h2:mem:testDb"
		}
	}
	production {
		dataSource {
                        dbCreate = "update" // one of 'create', 'create-drop','update'
                        url = "jdbc:postgresql://localhost/contro"
		}
	}
}