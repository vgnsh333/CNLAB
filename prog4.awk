BEGIN{
    c1=0;
    c2=0;
    p1=0;
    p2=0;
    t1=0;
    t2=0;
}
{
    if($1=="r" && $3=="_1_" && $4=="AGT")
    {
	p1=p1+$8;
	c1++;
	t1=$2;
    }
    if($1=="r" && $3=="_2_" && $4=="AGT")
    {   
	p2=p2+$8;
	c2++;
	t2=$2;
    }  
}
END{
    printf("Throughput of n0 to n1: %f Mpbs \n",(c1*p1*8)/(t1*1000000));
    printf("Throughput of n1 to n2: %f",(c2*p2*8)/(t2*1000000));
}

