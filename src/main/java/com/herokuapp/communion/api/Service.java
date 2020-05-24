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

@WebServlet("/api/service")
public class Service extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
		resp.setContentType("application/json");
		try{
			if (req.getParameterValues("srv") != null){
				String srv = req.getParameter("srv");
				if (srv.equals("topforums")){
					topForums(req, resp);
				} else if(srv.equals("search")){

				} else if(srv.equals("forums")){
					forums(req, resp);
				} else if(srv.equals("sections")){
                    sections(req,resp);
				} else if(srv.equals("topics")){
					topics(req,resp);
				} else if(srv.equals("posts")){
                    posts(req, resp);
				}
				else {
					out.print(new Gson().toJson(new ServerMessage("error","invalid path")));
				}
			}
			else {
				out.print(new Gson().toJson(new ServerMessage("ok","API")));
			}
		}
		catch (Exception e) {
			out.print(new Gson().toJson(new ServerMessage("execption",e.getMessage())));
		}
	}

    private void posts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, URISyntaxException {
        PrintWriter out = resp.getWriter();
        if(req.getParameterValues("topicid") != null){
            int topicid = Integer.parseInt(req.getParameter("topicid"));
            out = resp.getWriter();
            Gson gson = new Gson();
            Database db = Database.getInstance();
            out.print(gson.toJson(db.getTopicPosts(topicid)));
            out.flush();
        } else{
            out.print(new Gson().toJson(new ServerMessage("error","no topicid parameter")));
        }
    }

    private void topics(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException, SQLException, URISyntaxException {
		PrintWriter out = resp.getWriter();
		if(req.getParameterValues("sectionid") != null){
			int sectionId = Integer.parseInt(req.getParameter("sectionid"));
			out = resp.getWriter();
			Gson gson = new Gson();
			Database db = Database.getInstance();
            out.print(gson.toJson(db.getSecitonTopics(sectionId)));
			out.flush();
		} else{
			out.print(new Gson().toJson(new ServerMessage("error","no sectionid parameter")));
		}
	}

	private void sections(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException, URISyntaxException {
        PrintWriter out = resp.getWriter();
        if(req.getParameterValues("forumid") != null){
            int forumId = Integer.parseInt(req.getParameter("forumid"));
            out = resp.getWriter();
            Gson gson = new Gson();
            Database db = Database.getInstance();
            if (req.getParameterValues("sectionid") != null){
                int sectionId = Integer.parseInt(req.getParameter("sectionid"));
                out.print(gson.toJson(db.getSubsections(forumId, sectionId)));
            }
            else {
                out.print(gson.toJson(db.getForumSections(forumId)));
            }
            out.flush();
        } else{
            out.print(new Gson().toJson(new ServerMessage("error","no forumid parameter")));
        }
    }

    private void forums(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException, SQLException, URISyntaxException {
		PrintWriter out = resp.getWriter();
		if(req.getParameterValues("userid") != null){
			int userid = Integer.parseInt(req.getParameter("userid"));
			out = resp.getWriter();
			Gson gson = new Gson();
			Database db = Database.getInstance();
			out.print(gson.toJson(db.userForums(userid)));
			out.flush();
		} else{
			out = resp.getWriter();
			Gson gson = new Gson();
			Database db = Database.getInstance();
			out.print(gson.toJson(db.getForums()));
			out.flush();
		}
	}

	private void topForums(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException, SQLException, URISyntaxException {
		PrintWriter out = resp.getWriter();
		Gson gson = new Gson();
		int num;
		if (req.getParameterValues("num") != null)
			num = Integer.parseInt(req.getParameter("num"));
		else 
			num = 3;
		Database db = Database.getInstance();
		out.print(gson.toJson(db.topForums(num)));
		out.flush();
	}
}
