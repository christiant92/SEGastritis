/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Controlador;

import Modelo.BaseConocimiento;
import Modelo.DeteccionSintomas;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author christian
 */
@WebServlet(name = "GestionSintomas", urlPatterns = {"/GestionSintomas"})
public class GestionSintomas extends HttpServlet {
    private BaseConocimiento baseConoc = new BaseConocimiento();
    private DeteccionSintomas detSintomas = new DeteccionSintomas();
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GestionSintomas</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GestionSintomas at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String respuesta;
        
        /*se recepciona la respuesta y se envia al SE*/
        if("Aceptar".equals(request.getParameter("respuesta"))){
            respuesta = request.getParameter("resp");
            detSintomas.ingresarRespuestaSintoma(respuesta.equals("Si")?"si":"no"); /*Si, No*/
            request.setAttribute("tipo", detSintomas.getTipo());
            request.setAttribute("sentencia", detSintomas.getSentencia());
            request.getRequestDispatcher("se_pregunta.jsp").forward(request, response);
            System.out.println(respuesta);
        }
        
        /*inicio del diagnostico*/
        if("Comenzar".equals(request.getParameter("iniciar"))){
            String ruta = getServletContext().getRealPath("BC.CLP");
            
            baseConoc.iniciar(ruta);
            detSintomas.obtenerHechoActual();
            /*enviamos el tipo de decision, y el valor*/
            request.setAttribute("tipo", detSintomas.getTipo());
            request.setAttribute("sentencia", detSintomas.getSentencia());
            request.getRequestDispatcher("se_pregunta.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
