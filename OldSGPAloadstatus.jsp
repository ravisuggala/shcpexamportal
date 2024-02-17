


<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<center><h3>
<% 
String str;
if((str=(String)session.getAttribute("importresult"))!=null)
	out.println(str);

if(session.getAttribute("target")!=null)
{
	String target=session.getAttribute("target").toString();
	
	if(target.equals("smap"))
%>
	

<br><br>
<a href="javascript:history.back();"><font size=3 color=red>&lt;&lt;Back</font></a>
<%

session.removeAttribute("target");
} %>
</h3>
</center>	
	
<br></br>
<br></br>
<br></br>





		