package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.Post;
import com.herokuapp.communion.models.Section;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addpost")
public class AddPost extends HttpServlet{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        Post post;
        post = new Post(-1,Integer.valueOf(req.getParameter("uid")),
                Integer.valueOf(req.getParameter("topicId")),
                req.getParameter("postName"),
                req.getParameter("post"));

        try {
            if (Database.getInstance().newPost(post)){
                resp.sendRedirect("Forum.jsp?forumId=" + req.getParameter("forumId"));
            } else {
                resp.sendRedirect("Error.jsp?message=section_didn't_created.");
            }
        } catch(Exception e){
            resp.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ","_"));
        }
    }
}
