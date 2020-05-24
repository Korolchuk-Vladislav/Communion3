package com.herokuapp.communion.api.soap.cxf;

import com.herokuapp.communion.models.Update;
import com.herokuapp.communion.models.Updates;

import javax.jws.WebService;

/**
 * Created by Александр on 28.05.2017.
 */
@WebService
public interface SOAPUpdates {
    public String changeString(String input);

    public int updatesCount();

    public Updates getUpdate(int id);

    public Updates getUpdatesFrom(int id);

    public Updates getUpdatesBetween(int idFrom, int idTo);
}
