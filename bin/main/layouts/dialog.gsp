<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        
        <script src="${resource(dir:'js',file:'jquery-3.3.1.min.js')}"></script>
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
    <div class="container-fluid">
        <g:layoutBody />
    </div>
</body>
</html>