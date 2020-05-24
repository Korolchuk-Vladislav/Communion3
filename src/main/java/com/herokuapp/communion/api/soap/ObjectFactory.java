
package com.herokuapp.communion.api.soap;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.herokuapp.communion.api.soap package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {


    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.herokuapp.communion.api.soap
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetUpdateRequest }
     * 
     */
    public GetUpdateRequest createGetUpdateRequest() {
        return new GetUpdateRequest();
    }

    /**
     * Create an instance of {@link GetUpdateResponce }
     * 
     */
    public GetUpdateResponce createGetUpdateResponce() {
        return new GetUpdateResponce();
    }

}
