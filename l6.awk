BEGIN{tot=0;}
{
    if($1=="r")
    {
	tot=tot+$6;
	printf("%f\t%d\t\n",$2,tot)>>"cdma.xgr"
    }
}
END{}
