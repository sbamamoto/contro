package contro

class TabletController {

    def index = { 
        def rooms = Room.list(sort:"name")
        println rooms
        [rooms:rooms]
    }
}
