package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.Forum;
import com.herokuapp.communion.models.Topic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

@WebServlet("/Test")
public class Test extends HttpServlet {

	private Connection getConnection() throws SQLException, URISyntaxException{
		return Database.getConnection();
	}
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
 
        resp.setContentType("text/html; charset=UTF-8");
    	resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        
        try{
        	Database.getInstance().newTopic(new Topic(-1,137981094,2,"tsd",new Date()));
        }
        catch (Exception e) {
        	out.println("exception: " + e.getMessage());
		}
    }
}
