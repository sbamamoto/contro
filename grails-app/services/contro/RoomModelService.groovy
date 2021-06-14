package contro

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap

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
}