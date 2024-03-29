package contro

import grails.converters.JSON

class RoomController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def roomModelService

    def index = {
        [rooms: Room.list().sort{ it.showOrder } , roomInstanceTotal: Room.count()]
    }

    def apilistrooms = {
        println "s#####################################"
        def rooms = Room.list().sort{ it.showOrder }
        println rooms
        [rooms:rooms]
    }

    def apigetemptyroom = {
        render new Room() as JSON
    }

    def apiupdateroom = {
        println "-------------------- "+request.JSON
        roomModelService.saveJsonRoom(request.JSON['room'])
        render "OK"
    }

    def apideleteroom = {
        roomModelService.deleteRoom(params.id.toInteger())
        render "OK"
    }

    def apilistdevices = {
        def room = Room.get(params.id)

        println room
        def devices = []

        for (device in room.devices) {
            devices.add(device)
        }

        render devices as JSON
    }

    def apigetroom = {
        def room = Room.get(params.id)
        render room as JSON
    }


    def switchDevices = {
        def room = Room.get(params.id)
        println "++++++++++++++++++ "+room
        [room:room]
    }

    def list = {
        [roomInstanceList: Room.list().sort{ it.showOrder } , roomInstanceTotal: Room.count()]
    }

    def create = {
        def roomInstance = new Room()
        roomInstance.properties = params
        
        render (view:"edit", model: [roomInstance: roomInstance, allDevices: Device.list().sort { it.description }])
    }

    def edit = {
        def roomInstance = Room.get(params.id)
        if (!roomInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
            redirect(action: "list")
        }
        else {
            def roomDevices = []
            roomInstance.devices.each{
                roomDevices.add(it.device)
            }
            return [roomInstance: roomInstance, allDevices:Device.list().sort{ it.description }, associatedDevices:roomDevices]
        }
    }

    def delete = {
        def roomInstance = Room.get(params.id)
        if (roomInstance) {
            try {
                roomModelService.deleteRoom(params)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'room.label', default: 'Raum'), params.id])}"
                flash.textClass="text-success"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'room.label', default: 'Raum'), params.id])}"
                flash.textClass="text-danger"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Raum'), params.id])}"
            flash.textClass="text-danger"
            redirect(action: "list")
        }
    }
    
    
    def saveRoom = {
        def room
        if (params.id) {
            room = Room.get(params.id)
        }
        else {
            room = new Room();
        }
        room.devices?.clear()
        room.properties = params
        println params
        roomModelService.saveRoom(params)
        flash.message="${message(code: 'default.updated.message', args: [message(code: 'room.label', default: 'Raum '), room.name])}"
        flash.textClass="text-success"
        redirect action:"list"
    }
}
