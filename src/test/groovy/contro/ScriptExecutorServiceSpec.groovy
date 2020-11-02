package contro

import grails.testing.services.ServiceUnitTest
import spock.lang.Specification

class ScriptExecutorServiceSpec extends Specification implements ServiceUnitTest<ScriptExecutorService>{

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }
}
