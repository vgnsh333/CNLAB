import java.net.*;
import java.util.*;
import java.io.*;

public class TcpS{
    public static void main(String args[]){
	try{
	    ServerSocket sskt=new ServerSocket(4000);
	    while(true){
		Socket obj1=sskt.accept();
		DataInputStream din=new DataInputStream(obj1.getInputStream());
		DataOutputStream dout=new DataOutputStream(obj1.getOutputStream());
		String name=din.readLine();
		FileReader f=new FileReader(name);
		BufferedReader b=new BufferedReader(f);
		String data;
		while((data=b.readLine())!=null){
		    System.out.println(data);
		    dout.writeBytes(data+'\n');
		}
		f.close();
		dout.writeBytes("-1\n");
	    }
	}
	catch(Exception e){
	     System.out.println(e);
	 }
    }
}
	
