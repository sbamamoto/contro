package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import org.grails.web.json.JSONObject

@Transactional
class RoomModelService {

    @Transactional
    def saveRoom(GrailsParameterMap params) {
        Room room
        if (params.id){
            room = Room.get(params.id)
        }
        else {
            room = new Room()
        }
        room.properties = params
        return room.save(flush: true)
    }

    @Transactional
    Room saveJsonRoom(JSONObject jsonRoom) {
        println "::::::::::::::: "+jsonRoom.devices
        println jsonRoom.title

        Room room = Room.get(jsonRoom.id)

        if (room == null) {
            room = new Room();
        }

        room.devices.clear()
        room.save(flush:true, failOnError:true)
        for (dev in jsonRoom.devices) {
            println " xxxxxxxxxxxxx: " + dev.title
            room.addToDevices(Device.get(dev.id))
        }

        room.name = jsonRoom.title
        room.showOrder = jsonRoom.showOrder
        room.image = jsonRoom.image

        room.save(flush:true, failOnError:true)
        println " ------------------------ SAVED -----------------------"
        return room;
    }


    @Transactional
    def saveRoomImage (id, imagePath) {
        Room room
        room = Room.get(id)
        room.image = imagePath
        return room.save(flush: true)
    }

    @Transactional
    def deleteRoom(GrailsParameterMap params) {
        Room room
        if (params.id){
            room = Room.get(params.id)
            room.delete(flush: true)
        }
    }

    def deleteRoom(Integer roomId) {
        Room room = Room.get(roomId)
        if (room != null) {
            room.delete(flush: true, failOnError: true)
        }
    }
}