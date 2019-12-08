import java.net.*;
import java.io.*;
import java.util.*;

public class TcpC{
    public static void main(String args[]){
	try{
	    Socket cskt=new Socket("127.0.0.1",4000);
	    DataInputStream din=new DataInputStream(cskt.getInputStream());
	    DataOutputStream dout=new DataOutputStream(cskt.getOutputStream());
	    BufferedReader in=new BufferedReader(new InputStreamReader(System.in));
	    System.out.println("Enter the file name: ");
	    String file,data;
	    file=in.readLine();
	    dout.writeBytes(file+'\n');
	    System.out.println("Enter the new file name: ");
	    String nfile=in.readLine();
	    PrintWriter f=new PrintWriter(nfile);
	//    char buffer[];
	    while(true){
		data=din.readLine();
		if(data.equals("-1"))
		    break;
	//	buffer=new char[data.length()];
		f.println(data);
	    }
	    f.close();
	    cskt.close();
	}
	catch(Exception e){
	    System.out.println(e);
	}
    }
}
