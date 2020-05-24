package com.herokuapp.communion.webapp;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/Registrate")
public class Registrate extends HttpServlet{
	
	private Database db;
	{
		db = Database.getInstance();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try{
			req.setCharacterEncoding("UTF-8");
			int userId = 0;
            for (Cookie cookie : req.getCookies()) {
                if (cookie.getName().equals("uid"))
                    userId = Integer.valueOf(cookie.getValue());
            }
            if (userId == 0){
                resp.sendRedirect("Error.jsp?message=no userId(uid) cookie taken," +
                        " please go to start page and try agean.");
            }
            int age = Integer.valueOf(req.getParameter("age"));
			String country = req.getParameter("country");
			String region = req.getParameter("region");
			String city = req.getParameter("city");
			String about = req.getParameter("about");
			db.updateUser(userId, age, country, region, city, about);
			resp.sendRedirect("Main.jsp");
		}
		catch (Exception e) {
			resp.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ", "_"));
		}
	}
}
