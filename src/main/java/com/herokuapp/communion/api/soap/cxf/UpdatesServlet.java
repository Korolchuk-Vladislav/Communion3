package com.herokuapp.communion.api.soap.cxf;

import javax.servlet.ServletConfig;
import javax.servlet.annotation.WebServlet;
import javax.xml.ws.Endpoint;
import org.apache.cxf.Bus;
import org.apache.cxf.BusFactory;
import org.apache.cxf.transport.servlet.CXFNonSpringServlet;

@WebServlet("/updates/*")
public class UpdatesServlet extends CXFNonSpringServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void loadBus(ServletConfig sc) {
        super.loadBus(sc);
        Bus bus = getBus();
        BusFactory.setDefaultBus(bus);
        Endpoint.publish("/getUpdates", new UpdatesService());
    }
}
