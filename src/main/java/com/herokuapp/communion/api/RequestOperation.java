package com.herokuapp.communion.api;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;

public class RequestOperation {
    public static void requestBody(HttpServletRequest request, StringBuffer sb, BufferedReader bufferedReader) throws IOException {
        try {
            //InputStream inputStream = request.getInputStream();
            //inputStream.available();
            //if (inputStream != null) {
            bufferedReader =  request.getReader() ; //new BufferedReader(new InputStreamReader(inputStream));
            char[] charBuffer = new char[128];
            int bytesRead;
            while ( (bytesRead = bufferedReader.read(charBuffer)) != -1 ) {
                sb.append(charBuffer, 0, bytesRead);
            }
            //} else {
            //        sb.append("");
            //}

        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }
    }
}
