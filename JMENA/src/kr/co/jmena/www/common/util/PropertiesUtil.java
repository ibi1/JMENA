package kr.co.jmena.www.common.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;

public class PropertiesUtil {

    private Properties props = null;
    
    public PropertiesUtil(String strPropertiesFileName) {
    	
    	props = new Properties();
    	
        try {
        	props.load(new FileInputStream(getPropertiesPath() + strPropertiesFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public String getProperty(String key) {
        return props.getProperty(key);
    }
    
    public int getPropertyInt(String key) {
        return Integer.parseInt(props.getProperty(key));
    }
    
    public boolean getPropertyBoolean(String key) {
        return Boolean.valueOf(props.getProperty(key)).booleanValue();
    }
    public void setBoolean(String key, boolean ret) {
        props.setProperty(key, String.valueOf(ret));
    }
    
	private String getPropertiesPath() {
		
        ClassLoader cl = null;
        URL url = null;

        cl = Thread.currentThread().getContextClassLoader();
        
        if( cl == null ) {
            cl = ClassLoader.getSystemClassLoader(); 
        }
        
        url = cl.getResource("");
        
        return url.getPath();
	}    
}
