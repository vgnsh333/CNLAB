import java.net.*;
import java.util.*;
import java.io.*;

public class UdpC{
    public static void main(String args[]) throws Exception{
	int sp=10000,cp=10001;
	DatagramSocket ds=new DatagramSocket(sp);
	byte buffer[]=new byte[1024];
	BufferedReader in=new BufferedReader(new InputStreamReader(System.in));
	InetAddress ia=InetAddress.getLocalHost();
	while(true){
	    String out;
	    System.out.print("Client: ");
	    out=in.readLine();
	    buffer=out.getBytes();
	    ds.send(new DatagramPacket(buffer,out.length(),ia,cp));
	    String inc;
	    DatagramPacket p=new DatagramPacket(buffer,buffer.length);
	    ds.receive(p);
	    inc=new String(p.getData(),0,p.getLength());
	    System.out.println("Server : "+inc);
	}
    }
}
	
