package contro

class Interface {

    String url
    String description
    String type

    static constraints = {
        url(nullable:false)
    }
    
    def String toString() {
        return description
    }
}
