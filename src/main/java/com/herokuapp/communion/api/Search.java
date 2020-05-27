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


@SuppressWarnings("serial")
@WebServlet("/search")
public class Search extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String clientOrigin = req.getHeader("origin");

        resp.setHeader("Access-Control-Allow-Origin", clientOrigin);
        resp.setHeader("Access-Control-Allow-Methods", "GET");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type");
        resp.setHeader("Access-Control-Max-Age", "86400");

        PrintWriter out = resp.getWriter();
        String res;
        try {
            if (req.getParameter("type") != null && req.getParameter("type").equals("forums")){
                res = new Gson().toJson(Database.getInstance().searchForums(req.getParameter("key")));
                out.print(res);
            } else if (req.getParameter("type") != null && req.getParameter("type").equals("users")) {

            } else if (req.getParameter("type") != null && req.getParameter("type").equals("userforums")) {
                res = new Gson().toJson(Database.getInstance().searchForums(
                        req.getParameter("key"),
                        Integer.parseInt(req.getParameter("uid")
                        )));
                out.print(res);
            }
            else{
                out.print(ServerMessage.ERROR_INVALID_PARAMS);
            }
        }
        catch (Exception e){
            res = new Gson().toJson(new ServerMessage().setStatus(e.getClass().toString()).setMessage(e.getMessage()));
            out.print(res);
        }
    }
}
