package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/Login")
public class Login extends HttpServlet {
	private Database db;
	{
		db = Database.getInstance();
	}
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {        
		
		String uid = req.getParameter("uid");
        String first_name = req.getParameter("first_name");
        String last_name = req.getParameter("last_name");
        String photo = req.getParameter("photo");
        String photo_rec = req.getParameter("photo_rec");
        String hash = req.getParameter("hash");
		try{
	        if (db.newUser(new User(Integer.valueOf(uid), hash, first_name, last_name, photo, photo_rec))){
                Cookie cookie = new Cookie("uid",req.getParameter("uid"));
                cookie.setMaxAge(365 * 24 * 60 * 60);
                resp.addCookie(cookie);
	        	resp.sendRedirect("/Registration.jsp");
	        }
	        else{
	        	if (db.signin(new User(Integer.valueOf(uid), hash, first_name, last_name, photo, photo_rec))){
                    Cookie cookie = new Cookie("uid",req.getParameter("uid"));
                    cookie.setMaxAge(365 * 24 * 60 * 60);
                    resp.addCookie(cookie);
	        		resp.sendRedirect("/Main.jsp");
	        	}
	        	else{
	        		resp.sendRedirect("/Error.jsp?message=can't_registrate._call_administration_pls.");	
	        	}
	        }
	    }
	    catch(Exception e){
	    	resp.sendRedirect("/Error.jsp?message=SERVER_EXCEPTION:_" + e.getMessage().replaceAll(" ", "_"));
	    }
    }
}