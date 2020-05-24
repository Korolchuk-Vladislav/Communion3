package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.Forum;
import com.herokuapp.communion.models.Topic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addtopic")
public class addTopic extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");

        Topic topic;

        topic = new Topic(-1,Integer.valueOf(req.getParameter("uid")),
                Integer.valueOf(req.getParameter("sectionId")),
                req.getParameter("title"));

        try {
            if (Database.getInstance().newTopic(topic)){
                resp.sendRedirect("Forum.jsp?forumId=" + req.getParameter("forumId"));
            } else {
                resp.sendRedirect("Error.jsp?message=forum_didn't_created.");
            }
        } catch(Exception e){
            resp.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ","_"));
        }
    }
}
