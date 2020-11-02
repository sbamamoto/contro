package contro

class HomematicController {

    def homematicDataModelService

    def index() {
        def x = request.JSON
        println "+++++++++++++   "+x
        homematicDataModelService.updateData(x)
        render(text: 'OK')
     }

}
