package com.herokuapp.communion.api;

import com.google.gson.Gson;
import com.herokuapp.communion.webapp.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.SQLException;

@WebServlet("/api/user")
public class UserService extends HttpServlet{

	private Database db;
	private Gson gson;
	{
		db = Database.getInstance();
		gson = new Gson();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
		resp.setContentType("application/json");
		try{
			if (req.getParameterValues("srv") != null){
				String srv = req.getParameter("srv");
				if (srv.equals("ownforums")){
					ownForums(req, resp);
				} else if (srv.equals("forums")){
					userForums(req, resp);
				} else if (srv.equals("userinfo")){
					userInfo(req, resp);
				} else if (srv.equals("gotuser")){
                    gotUser(req, resp);
                } else {
					out.println(gson.toJson(ServerMessage.ERROR_INVALID_PARAMS));
				}
			}
			else{
				out.print(gson.toJson(ServerMessage.ERROR_INVALID_PARAMS));
			}
		}
		catch(Exception e){
			out.print(gson.toJson(new ServerMessage(e.getMessage()).setStatus("exception")));
		}
	}

	public void ownForums(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException, URISyntaxException, SQLException {
		PrintWriter out = resp.getWriter();
		resp.setContentType("application/json");
		if (req.getParameterValues("userId") != null){
			out.print(gson.toJson(db.userForums(Integer.valueOf(req.getParameter("userId")))));
		}
		else {
			out.print(gson.toJson(ServerMessage.ERROR_INVALID_PARAMS));
		}
	}

	public void gotUser(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, URISyntaxException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        if (req.getParameterValues("userId") != null) {
            try {
                if (db.getUser(Integer.valueOf(req.getParameter("userId"))) != null)
                    out.print(gson.toJson(new ServerMessage("ok", "1")));
                else
                    out.print(gson.toJson(new ServerMessage("ok", "0")));
            } catch (SQLException e) {
                out.print(gson.toJson(new ServerMessage("ok", "0")));
            }
        } else {
            out.print(gson.toJson(ServerMessage.ERROR_INVALID_PARAMS));
        }
    }
	public void userInfo(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException, URISyntaxException, SQLException {
		PrintWriter out = resp.getWriter();
		resp.setContentType("application/json");
		if (req.getParameterValues("userId") != null){
			out.print(gson.toJson(db.getUser(Integer.valueOf(req.getParameter("userId")))));
		}
		else {
			out.print(gson.toJson(ServerMessage.ERROR_INVALID_PARAMS));
		}
	}

	public void userForums(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException, URISyntaxException, SQLException {
		PrintWriter out = resp.getWriter();
		resp.setContentType("application/json");
		if (req.getParameterValues("userId") != null){
			out.print(gson.toJson(db.userForums(Integer.valueOf(req.getParameter("userId")))));
		}
		else {
			out.print(gson.toJson(ServerMessage.ERROR_INVALID_PARAMS));
		}
	}

}
