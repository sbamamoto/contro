//
//
quartz {
    autoStartup = true
    jdbcStore = false
}

environments {
    test {
        quartz {
            autoStartup = true
        }
    }
    production {
        quartz {
            autoStartup = true
        }
    }
    development {
        quartz {
            autoStartup = true
        }
    }
}