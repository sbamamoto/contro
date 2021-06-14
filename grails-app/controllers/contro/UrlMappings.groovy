package contro

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"room", action:"index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
