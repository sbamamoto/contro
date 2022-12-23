package contro

class Value {

    String key
    String value
    String channel
    Date lastChange
    boolean isMainValue
    boolean isEditable
    String guiControlType
    String defaultValue
    boolean isAutomatic

    static constraints = {
        lastChange(nullable:true)
        guiControlType(nullable:true)
        defaultValue(nullable:true)
    }
    
    static mapping = {
        isMainValue defaultValue: false
        isEditable defaultValue: false
        isAutomatic defaultValue: true
    }
}
