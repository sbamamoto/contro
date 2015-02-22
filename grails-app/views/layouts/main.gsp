<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <script src="${resource(dir:'js',file:'jquery-2.1.1.min.js')}"></script>
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'bootstrap-theme.min.css')}" />
        <script src="${resource(dir:'js',file:'bootstrap.min.js')}"></script>
        <!--link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" /-->
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />	
        <g:layoutHead />
    <r:layoutResources />
</head>
<body>
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
          <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"><h1><b>Contro</b></h1></a>
            </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li id="tablet"><a href="${createLink(controller:"tablet")}"><h1>Schalten</h1></a></li>
                    <li id="week"><a href="${createLink(controller:"weekView")}"><h1>Wochenplan</h1></a></li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h1>Einstellungen</h1> <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li id="rooms"><a href="${createLink(controller:"room")}"><h1>Räume</h1></a></li>
                            <li id="devices"><a href="${createLink(controller:"device")}"><h1>Geräte</h1></a></li>
                            <li id="timing"><a href="${createLink(controller:"timing")}"><h1>Zeiten</h1></a></li>
                            <li id="partymode"><a href="${createLink(controller:"partymode")}"><h1>Partymode</h1></a></li>
                        </ul>
                    </li>
                    <li id="all"><a href="${createLink(controller:"general")}"><h1>Alle</h1></a></li>

                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <g:layoutBody />
</body>
</html>