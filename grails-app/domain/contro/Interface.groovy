package contro

class Interface {

    String url
    String description
    static constraints = {
        url(nullable:false)
    }
    
    def String toString() {
        return description
    }
}
