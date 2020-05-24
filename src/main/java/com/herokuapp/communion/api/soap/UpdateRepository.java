package com.herokuapp.communion.api.soap;

import javax.annotation.PostConstruct;

import com.herokuapp.communion.models.Update;
import com.herokuapp.communion.models.Updates;
import com.herokuapp.communion.webapp.Database;
import org.springframework.stereotype.Component;

@Component
public class UpdateRepository {

    private static Updates updates;

    @PostConstruct
    public void initData() {
        try{
            updates = Database.getInstance().getUpdates();
        } catch (Exception e){
            updates = new Updates();
        }
    }

    public int getUpdatesCount(){
        return updates.getUpdates().size();
    }

    public Update getUpdate(int i) {
        return updates.getUpdates().get(i);
    }
}
