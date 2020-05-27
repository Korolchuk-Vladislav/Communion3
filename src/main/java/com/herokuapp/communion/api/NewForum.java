package com.herokuapp.communion.api;

import com.google.gson.Gson;
import com.herokuapp.communion.models.Forum;
import com.herokuapp.communion.webapp.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import static com.herokuapp.communion.models.User.GUEST_ID;

@SuppressWarnings("serial")
@WebServlet("/api/newforum")
public class    NewForum  extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String clientOrigin = request.getHeader("origin");

        response.setHeader("Access-Control-Allow-Origin", clientOrigin);
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setHeader("Access-Control-Max-Age", "86400");

        PrintWriter out = response.getWriter();

        StringBuffer sb = new StringBuffer();
        BufferedReader bufferedReader = null;
        String content = "";

        RequestOperation.requestBody(request, sb, bufferedReader);
        String input = sb.toString();

        try {
            Forum forum = new Gson().fromJson(input,Forum.class);
            if (forum.getUserid() != GUEST_ID) {
                Database.getInstance().newForum(forum);
            } else {
                out.print(new Gson().toJson(ServerMessage.ERROR_ACCESS_DENIED));
            }
        } catch (Exception e) {
            out.print(new Gson().toJson(new ServerMessage("exception",e.getMessage())));
        }

        out.print(new Gson().toJson(ServerMessage.SUCCESS_MESSAGE));

    }

}
