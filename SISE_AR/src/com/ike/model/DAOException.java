/*
 * DAOException.java
 *
 * Created on 22 de marzo de 2006, 05:57 PM
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package com.ike.model;

/*
 *
 * @author cabrerar
 */
public class DAOException extends Exception{
    
    /* Creates a new instance of DAOException */
    public DAOException() {
        super();
    }

    public DAOException(String msg){
        super(msg);
    }    
    public DAOException(Throwable t){
        super(t);
    }
    
    public DAOException(String msg, Throwable t ){
        super(msg, t);
    }

}
