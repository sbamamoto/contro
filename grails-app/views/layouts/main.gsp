<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        
        <script src="${resource(dir:'js',file:'jquery-2.1.1.min.js')}"></script>
        <script src="${resource(dir:'js',file:'jquery-ui.min.js')}"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="${resource(dir:'js',file:'bootstrap.min.js')}"></script>
        <script src="${resource(dir:'js',file:'bootstrap-slider.min.js')}"></script>
        
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-theme.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'contro.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-slider.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'materialdesignicons.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'cntr.css')}" />        
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />	
        <g:layoutHead />
    <r:layoutResources />
</head>
<body>    
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" style="font-size:50px;font-weight:700" href="${createLink(controller:'processor', action:'addInitialData')}"><b>Contro</b></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon iconic-button"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav">
                <li id="tablet" class="nav-item"><a class="nav-link cntr-menu-item-text" href="${createLink(controller:"tablet")}">Schalten</a></li>
                <li id="groups" class="nav-item"><a class="nav-link cntr-menu-item-text" href="${createLink(controller:'deviceGroup', action:'matrix')}">Gruppen</a></li>
                <li id="week" class="nav-item"><a class="nav-link cntr-menu-item-text" href="${createLink(controller:"weekView")}">Wochenplan</a></li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle cntr-menu-item-text" href="#" id="navbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Einstellungen</a>
                    <div class="dropdown-menu cntr-menu-item-text" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"room")}">Räume</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"device")}">Geräte</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"deviceGroup")}">Gerätegruppen</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"timing")}">Zeiten</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"partymode")}">Partymode</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"interface")}">Controller</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"processor")}">Processor</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"deviceType")}">Gerätetyp</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"Ability")}">Geräteeigenschaften</a>
                        <a class="dropdown-item cntr-menu-item-text" href="${createLink(controller:"Value")}">Geräteattribute</a>                        
                    </div>
                </li>
                <li class="nav-item" id="all"><a class="nav-link cntr-menu-item-text" href="${createLink(controller:"general")}">Alle</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </nav>

    <g:layoutBody />
</body>
</html>