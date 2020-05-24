package com.herokuapp.communion.api;

import com.herokuapp.communion.models.Update;
import com.herokuapp.communion.webapp.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.namespace.QName;
import javax.xml.soap.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/APIUpdates")
public class APIUpdates extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/xml");

        try {
            MessageFactory factory = MessageFactory.newInstance();
            SOAPMessage message = factory.createMessage();
            SOAPPart soapPart = message.getSOAPPart();
            SOAPEnvelope envelope = soapPart.getEnvelope();
            SOAPHeader header = envelope.getHeader();
            SOAPBody body = envelope.getBody();
            header.detachNode();

            QName updatesBody = new QName("http://communion.herokuapp.com", "body", "APIUpdates");
            SOAPBodyElement bodyElement = body.addBodyElement(updatesBody);

            for (Update upd : Database.getInstance().getUpdates().getUpdates()) {
                QName update = new QName("update");
                SOAPElement updateElement = bodyElement.addChildElement(update);

                QName id = new QName("id");
                SOAPElement idElement = updateElement.addChildElement(id);
                idElement.addTextNode(String.valueOf(upd.getId()));

                QName table = new QName("table");
                SOAPElement tableElement = updateElement.addChildElement(table);
                tableElement.addTextNode(upd.getTable());

                QName rows = new QName("rows");
                SOAPElement rowsElement = updateElement.addChildElement(rows);
                rowsElement.addTextNode(String.valueOf(upd.getId()) + "-" + String.valueOf(upd.getId()));
            }
            message.writeTo(resp.getOutputStream());
        } catch (Exception e){
            resp.getOutputStream().print(e.getMessage());
        }
    }
}
