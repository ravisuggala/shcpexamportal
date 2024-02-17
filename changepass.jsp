
<script language="javascript" src="./functions.js"></script>

<%@ page import = "dao.User" %>

<%
String header=new String();
User ur=(User)session.getAttribute("LoginRecord");
if(ur==null)
{
%>
<jsp:forward page="./index.jsp"></jsp:forward>
<%}
if(ur.getStatus().equals("admin"))
	header="./adminheader.jsp";
else if(ur.getStatus().equals("clerk"))
	header="./mainmenuheader.jsp";
else if(ur.getStatus().equals("ACE"))
	header="./aceheader.jsp";
else if(ur.getStatus().equals("faculty"))
	header="./facultyheader.jsp";


	
%>

<jsp:include page='<%= header %>' flush="true" />
<body>


			
			<form id="login" name= "passwordform" method="post" action="./ActionServlet" onsubmit="return verifypass();"> 
			 

    <h1><strong>Change Password</strong> </h1>
    
    <div>
    
    	<label for="login_username">Old Password</label> 
    	<input type="password" name="opass" id="login_username" class="field required" title="Please provide your username" />
    </div>			

    <div>
    	<label for="login_password">New Password</label>
    	<input type="password" name="npass" id="login_password" class="field required" title="Password is required" />
    </div>
    <div>
    	<label for="login_password">Confirm Password</label>
    	<input type="password" name="cpass" id="login_password" class="field required" title="Password is required" />
    </div>			
    			
    
    			<input type="hidden" name="option" value="changepass" />
    <div class="submit">
        <button type="submit">Submit</button>   
        
    </div>
    
  
</form>	
		



</body>