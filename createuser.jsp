
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
	
%>

<jsp:include page='<%= header %>' flush="true" />
<body>


			
			<form id="login" name= "passwordform" method="post" action="./ActionServlet" > 
			 

    <h1><strong>New User Creation</strong> </h1>
    
    <div>
    
    	<label for="login_username">User Name</label> 
    	<input type="text" name="user" id="login_username" class="field required" title="Please provide your username" />
    </div>			

    <div>
    	<label for="login_password">Password</label>
    	<input type="password" name="password" id="login_password" class="field required" title="Password is required" />
    </div>
    		<div>
    	<label for="login_password">Type</label>
    	<select size="1" name="type" id="type" align=left><option></option><option value="admin">Admin</option> 
        							<option value="Clerk">Clerk</option>
        							<option value="ACE">ACE</option>   
        </select>
    </div>	
    
    			<input type="hidden" name="option" value="createuser" />
    <div class="submit">
        <button type="submit">Submit</button>   
        
    </div>
    
  
</form>	
		



</body>