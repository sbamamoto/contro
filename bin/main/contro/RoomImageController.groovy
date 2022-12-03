package contro

import java.awt.image.BufferedImage

class RoomImageController {
    def roomModelService

    def save () {
        def imagePath = Setting.findBySetting('room.image.path').value
        println '**************+++'+params
        def file = request.getFile('roomImage')
        if (file && !file.empty) {
            roomModelService.saveRoomImage(params.roomId, file.getOriginalFilename())
            file.transferTo(new File(imagePath + '/' + file.getOriginalFilename()))
        }
        redirect(controller: 'room', action: 'edit', params: [id:params.id])
    }


    def renderImage = {

        println "########################"
        println params
        def imagePath = Setting.findBySetting('room.image.path').value
        def img = new File(imagePath+"/"+params.filename).bytes        

        println imagePath+'/'+params.filename;

        response.setHeader('Content-length', String.valueOf(img.length))
        response.contentType = 'image/jpg' // or the appropriate image content type
        response.outputStream << img
        response.outputStream.flush()

    }


}
