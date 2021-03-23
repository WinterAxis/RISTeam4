import java.io.*;
import java.sql.*;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.Desktop;
import java.net.URL;

import com.pd4ml.PD4ML;

/**
* Generates PDF from a simple HTML string. Page format, margins etc are default.
*/

@WebServlet("/reportPDF")
public class reportPDF extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			//Do POST to pass data
			PrintWriter out = response.getWriter();
			out.println("This page is intended to be accessed through a POST with patient data to pass to server. ");
			//doGet(request, response);
	

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PD4ML pd4ml = new PD4ML();
		pd4ml.setHtmlWidth(900);
		pd4ml.readHTML(new URL("http://localhost:8080/RISTeam4/report.jsp?oid="+request.getParameter("oid")));
		
		File pdf = File.createTempFile("result", ".pdf");
		FileOutputStream fos = new FileOutputStream(pdf);
		// render and write the result as PDF
		pd4ml.writePDF(fos);
		// alternatively or additionally: 
		// pd4ml.writeRTF(rtfos, false);
		// BufferedImage[] images = pd4ml.renderAsImages();
		
		// open the just-generated PDF with a default PDF viewer
		Desktop.getDesktop().open(pdf);

		String url = "displayOrder.jsp?oid="+request.getParameter("oid");
    response.sendRedirect(url);
	}

}


