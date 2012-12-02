package contro


import grails.converters.JSON
import grails.web.JSONBuilder
import org.codehaus.groovy.grails.web.json.JSONObject


class JsonController {

    def rooms() { 
        def rooms = Room.list();
        render (contentType:'text/json') {
            responseData {
                results =
                array {
                    rooms.each { room ->
                        results (
                        label: room.name,
                        devices : array {
                            room.devices.each { device ->
                                devices (
                                    label: device.description,
                                    device: device.device,
                                    dimmable: device.canDimm,   
                                    switchState: device.state
                                )
                            }
                        }
                        )
                    }
                }
            }
        }
    }
}