package com.herokuapp.communion.models;

import org.simpleframework.xml.ElementList;
import org.simpleframework.xml.Root;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import java.util.ArrayList;
import java.util.List;

@XmlAccessorType(XmlAccessType.FIELD)
public class Updates {
    private List<Update> updates;

    public Updates(){
        updates = new ArrayList<Update>();
    }

    public Updates(List<Update> updates){
        this.updates = updates;
    }

    public void setUpdates(List<Update> updates){
        this.updates = updates;
    }

    public List<Update> getUpdates(){
        return updates;
    }
}
