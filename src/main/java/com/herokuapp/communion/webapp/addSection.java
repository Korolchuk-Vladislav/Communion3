package com.herokuapp.communion.webapp;

import com.herokuapp.communion.models.Forum;
import com.herokuapp.communion.models.Section;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addsection")
public class addSection extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Section section;

        req.setCharacterEncoding("utf-8");

        int uid = Integer.valueOf(req.getParameter("uid"));
        int forumId = Integer.valueOf(req.getParameter("forumId"));
        String name = req.getParameter("name");

        if (req.getParameter("sectionId")!= null) {
            section = new Section(-1,forumId,name,Integer.valueOf(req.getParameter("sectionId")));
        } else {
            section = new Section(-1,forumId,name,-1);
        }
        try {
            if (Database.getInstance().newSection(section)){
                resp.sendRedirect("Forum.jsp?forumId=" + forumId);
            } else {
                resp.sendRedirect("Error.jsp?message=section_didn't_created.");
            }
        } catch(Exception e){
            resp.sendRedirect("Error.jsp?message=" + e.getMessage().replaceAll(" ","_"));
        }
    }
}
