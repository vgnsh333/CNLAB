import java.util.*;
import java.math.*;
import java.io.*;

public class rsa{
    BigInteger p,q,N,phi,e,d;
    Random r;
    int bl=1024;
    rsa(){
	r=new Random();
	p=BigInteger.probablePrime(bl,r);
	q=BigInteger.probablePrime(bl,r);
	N=p.multiply(q);
	System.out.println("here");
	phi=p.subtract(BigInteger.ONE).multiply(q.subtract(BigInteger.ONE));
	e=BigInteger.probablePrime(bl/2,r);
	System.out.println(e);
	while(phi.gcd(e).compareTo(BigInteger.ONE) > 0 && e.compareTo(phi) <0){
	   System.out.println( e.add(BigInteger.ONE));
	}
	d=e.modInverse(phi);
    }
    rsa(BigInteger e,BigInteger d,BigInteger N){
	this.e=e;
	this.d=d;
	this.N=N;
    }
    static String bytesToString(byte[] encrypted){
	String test="";
	for(byte b:encrypted){
	    test += Byte.toString(b);
	}
	return test;
    }
    byte[] encrypt(byte[] msg){
	return(new BigInteger(msg)).modPow(e,N).toByteArray();
    }
    byte[] decrypt(byte[] msg){
	return(new BigInteger(msg)).modPow(d,N).toByteArray();
    }
    public static void main(String args[]) throws Exception{
	rsa r=new rsa();
	DataInputStream in=new DataInputStream(System.in);
	String test;
	System.out.println("Enter the plain text: ");
	test=in.readLine();
	System.out.println("Encrypting string: "+test);
	System.out.println("Encrypting bytes: "+bytesToString(test.getBytes()));
	byte[] enp=r.encrypt(test.getBytes());
	byte[] denc=r.decrypt(enp);
	System.out.println("Decrypting bytes: "+bytesToString(denc));
	System.out.println("Decrypting string: "+(new String(denc)));
    }
}


