<%-- 
    Document   : index
    Created on : 19-jul-2015, 11:10:38
    Author     : christian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SE-FISI</title>
    </head>
    <body>
        <h2 align = "CENTER">SISTEMA EXPERTO PARA LA DETECCION DE GASTRITIS</h2>
        <h3 align = "CENTER">Bienvenido, presiona "Comenzar" para empezar el diagn&oacute;stico.</h3>
        
        <form action="GestionSintomas" method="post">
            <p align = "CENTER">
            <input type="submit" name = "iniciar" value="Comenzar"/>
            </p>
        </form> 
        
    </body>
</html>
