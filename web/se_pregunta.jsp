<%-- 
    Document   : se
    Created on : 19-jul-2015, 15:14:43
    Author     : christian
--%>

<%@page import="Controlador.GestionSintomas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SE-FISI</title>
    </head>
    <body>
        <h2>SE para el Diagnostico del Tipo de Gastritis</h2>
        
    <%
        //GestionSintomas gestorSintomas = new GestionSintomas();
        String preguntaSE = "", iniciar = "", solucionSE = "";
        boolean pregunta = false, solucion = false;
       
       System.out.println("COMENZAR" + request.getAttribute("tipo") + request.getAttribute("sentencia"));
       
       if(request.getAttribute("tipo") == "pregunta") {
            /*a = request.getParameter("rspta");*/
           preguntaSE = String.valueOf(request.getAttribute("sentencia"));
           preguntaSE = preguntaSE.replace("\"","");
           pregunta = true;
           solucion = false;
       }
       else if(request.getAttribute("tipo") == "solucion") {
           solucionSE = String.valueOf(request.getAttribute("sentencia"));
           solucionSE = solucionSE.replace("\"", "");
           pregunta = false;
           solucion = true;
       }
        
        /*out.print("<form action = se_pregunta.jsp method = post>");
        out.print("</form>");
        String variable = request.getParameter("iniciar");*/
        
        if(pregunta) {
        /*formulario de preguntas*/
        out.print("<form action = GestionSintomas method = post>");
        out.print("<div align=left><br>");
            out.print(preguntaSE);
            out.print("<hr>");
            out.print("<input type=radio name=resp value=Si /> Si <br>");
            out.print("<input type=radio name=resp value=No /> No <br>");
            out.print("<hr>");
            out.print("<input type=submit value=Aceptar name=respuesta />");
            out.print("</div>");
        out.print("</form>");
        }
        if(solucion) {
            out.print("<form action = index.jsp method = post>");
            out.print("<div align=left><br>");
                out.print("<hr>");
                out.print("Diagnostico Final: " + solucionSE + "<br>");
                out.print("<hr>");
                out.print("<input type=submit value=\"Nuevo Diagnostico\" name=inicio />");
            out.print("</div>");
            out.print("</form>");
        }
        
    %>
    
    </body>
</html>
