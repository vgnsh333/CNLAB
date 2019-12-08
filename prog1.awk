BEGIN{c=0;}
{
    if($1=="d")
    {
	c++;
	printf("packet drop %s with seq no. %d\n",$5,$11);
    }
}
END{
    printf("Total packet dropped: %d",c);}
