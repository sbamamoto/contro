<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        
        <script src="${resource(dir:'js',file:'jquery-2.1.1.min.js')}"></script>
        <script src="${resource(dir:'js',file:'jquery-ui.min.js')}"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="${resource(dir:'js',file:'bootstrap.min.js')}"></script>
        
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-theme.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'contro.css')}" />
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />	
        <g:layoutHead />
    <r:layoutResources />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="${createLink(controller:'processor', action:'addInitialData')}"><h1><b>Contro</b></h1></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="container-fluid">

    <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li id="tablet" class="nav-item"><a class="nav-link" href="${createLink(controller:"tablet")}"><h1>Schalten</h1></a></li>
                    <li id="week" class="nav-item"><a class="nav-link" href="${createLink(controller:"weekView")}"><h1>Wochenplan</h1></a></li>

                    <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><h1>Einstellungen</h1></a>
                         <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="${createLink(controller:"room")}"><h1>Räume</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"device")}"><h1>Geräte</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"timing")}"><h1>Zeiten</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"partymode")}"><h1>Partymode</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"interface")}"><h1>Controller</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"processor")}"><h1>Processor</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"deviceType")}"><h1>Gerätetyp</h1></a>
                            <a class="dropdown-item" href="${createLink(controller:"Ability")}"><h1>Geräteeigenschaften</h1></a>
                        </div>
                    </li>
                    <li class="nav-item" id="all"><a class="nav-link" href="${createLink(controller:"general")}"><h1>Alle</h1></a></li>

                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <g:layoutBody />
</body>
</html>