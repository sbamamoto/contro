package contro

class RoomController {

    static allowedMethods = [save: "POST", update: "POST", delete: "GET"]
    def roomModelService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        
        [roomInstanceList: Room.list().sort{ it.name } , roomInstanceTotal: Room.count()]
        
    }

    def create = {
        def roomInstance = new Room()
        roomInstance.properties = params
        
        render (view:"edit", model: [roomInstance: roomInstance, allDevices: Device.list().sort { it.description }])
    }

//    def save = {
//        def roomInstance = new Room(params)
//        if (roomInstance.save(flush: true)) {
//            flash.message = "${message(code: 'default.created.message', args: [message(code: 'room.label', default: 'Room'), roomInstance.id])}"
//            redirect(action: "show", id: roomInstance.id)
//        }
//        else {
//            render(view: "create", model: [roomInstance: roomInstance])
//        }
//    }

//    def show = {
//        def roomInstance = Room.get(params.id)
//        if (!roomInstance) {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
//            redirect(action: "list")
//        }
//        else {
//            [roomInstance: roomInstance]
//        }
//    }

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
            return [roomInstance: roomInstance, allDevices:Device.list(), associatedDevices:roomDevices]
        }
    }

//    def update = {
//        def roomInstance = Room.get(params.id)
//        if (roomInstance) {
//            if (params.version) {
//                def version = params.version.toLong()
//                if (roomInstance.version > version) {

//                    roomInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'room.label', default: 'Room')] as Object[], "Another user has updated this Room while you were editing")
//                    render(view: "edit", model: [roomInstance: roomInstance])
//                    return
//                }
//            }
//            roomInstance.properties = params
//            if (!roomInstance.hasErrors() && roomInstance.save(flush: true)) {
//                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'room.label', default: 'Room'), roomInstance.id])}"
//                redirect(action: "show", id: roomInstance.id)
//            }
//            else {
//                render(view: "edit", model: [roomInstance: roomInstance])
//            }
//        }
//        else {
//            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'room.label', default: 'Room'), params.id])}"
//            redirect(action: "list")
//        }
//    }

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
