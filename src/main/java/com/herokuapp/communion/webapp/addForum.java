package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.Forum;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addforum")
public class addForum extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Forum forum;

        req.setCharacterEncoding("utf-8");

        int uid = Integer.valueOf(req.getParameter("uid"));
        String title = req.getParameter("title");
        String image = req.getParameter("image");
        String about = req.getParameter("about");
        int isPublic = Integer.valueOf(req.getParameter("isPublic"));

        forum = new Forum(uid,title, image, about, isPublic);

        try {
            if (Database.getInstance().newForum(forum) && Database.getInstance().getForum(uid,forum.getTitle()) != null){
                resp.sendRedirect("Forum.jsp?forumId=" + Database.getInstance().getForum(uid,forum.getTitle()).getForumid());
            } else {
                resp.sendRedirect("Error.jsp?message=forum_didn't_created.");
            }
        } catch(Exception e){
            resp.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ","_"));
        }
    }
}
