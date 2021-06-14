package contro

class RoomImageController {
    def roomModelService

    def save () {
        def imagePath = Setting.findBySetting('room.image.path').value
        println '**************+++'+params
        def file = request.getFile('roomImage')
        if (file && !file.empty) {
            roomModelService.saveRoomImage(params.roomId, imagePath + '/' + file.getOriginalFilename())
            file.transferTo(new File(imagePath + '/' + file.getOriginalFilename()))
        }
        redirect(controller: 'room', action: 'edit', params: [id:params.id])
    }

}
