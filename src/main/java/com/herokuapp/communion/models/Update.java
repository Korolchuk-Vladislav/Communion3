package com.herokuapp.communion.models;

import org.simpleframework.xml.Element;
import org.simpleframework.xml.Root;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import java.sql.Date;

@XmlAccessorType(XmlAccessType.FIELD)
public class Update {
    public int id;
    public String table;
    public int idRow;

    public Update(int id, String table, int idRow) {
        this.id = id;
        this.table = table;
        this.idRow = idRow;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTable() {
        return table;
    }
    public void setTable(String table) {
        this.table = table;
    }

    public int getIdRow() {
        return idRow;
    }
    public void setIdRow(int idFrom) {
        this.idRow = idFrom;
    }
}
