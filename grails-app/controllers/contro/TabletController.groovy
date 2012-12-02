package contro

class TabletController {

    def index = { 
        def rooms = Room.findAll()
        println rooms
        [rooms:rooms]
    }
}
