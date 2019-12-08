import java.io.*;
import java.util.*;

public class bell {
	public static void main(String args[]){
	int A[][],D[],i,j,src,vnum,sn,dn;
	int max=999;
	System.out.println("Enter the number of vertices: ");
	Scanner in=new Scanner(System.in);
	vnum=in.nextInt();
	A=new int[vnum+1][vnum+1];
	D= new int[vnum+1];
	System.out.println("Enter the adj matrix ");
	for(i=1;i<=vnum;i++){
	for(j=1;j<=vnum;j++){
	System.out.println("From "+i+" to "+j+" : ");
	A[i][j]=in.nextInt();
	if(A[i][j]==0){
	A[i][j]=max;
	}
	}
	}
	System.out.println("Enter the src");
	src=in.nextInt();
	for(i=1;i<=vnum;i++)
	{
	D[i]=max;
	}
	D[src]=0;
	
	for(int node=1;node<=vnum;node++){
	for(sn=1;sn<=vnum;sn++){
	for(dn=1;dn<=vnum;dn++){
	if(A[sn][dn]!=max){
	if(D[dn]>D[sn]+A[sn][dn]){
	D[dn]=D[sn]+A[sn][dn];
	}
	}
	}
	}
	}
	for(int node=1;node<=vnum;node++){
	System.out.println("From "+src+" to "+node+" cost is: "+D[node]);
	}
	}
}
