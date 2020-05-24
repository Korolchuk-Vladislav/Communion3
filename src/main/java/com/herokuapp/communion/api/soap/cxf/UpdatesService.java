package com.herokuapp.communion.api.soap.cxf;

import com.herokuapp.communion.models.Update;
import com.herokuapp.communion.models.Updates;
import com.herokuapp.communion.webapp.Database;

import javax.jws.WebService;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by Александр on 28.05.2017.
 */
@WebService(endpointInterface = "com.herokuapp.communion.api.soap.cxf.SOAPUpdates")
public class UpdatesService implements SOAPUpdates {
    public String changeString(String input) {
        return "changed " + input;
    }

    public int updatesCount() {
        try{
            return Database.getInstance().getUpdates().getUpdates().size();
        } catch (Exception e){
            return 0;
        }
    }

    public Updates getUpdate(int id) {
        ArrayList<Update> ressrc = new ArrayList<Update>();
        try{
            ressrc.add(Database.getInstance().getUpdate(id));
            ressrc.add(Database.getInstance().getUpdate(id+1));
        } catch (Exception e){
            ressrc.add(new Update(0,e.getMessage(),0));
        }
        return new Updates(ressrc);
    }

    public Updates getUpdatesFrom(int id) {
        return new Updates();
    }

    public Updates getUpdatesBetween(int idFrom, int idTo) {
        return new Updates();
    }
}
