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

	
%>

<head>
<script language=javascript>

function populateSecValues(obj){
	// use here ajax call .. which will populate second box data
	var firstBoxValue = obj.value;
	var urlString ="./electivesubjects.jsp?selele="+firstBoxValue ;
	$.ajax({
	type: "POST",
	url: urlString ,
	success: function(result) {
	console.info("result"+result);
	$("#subject").html(result);
	}
	});
	}

</script>


</head>

<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

<%
String degree=miscUtil.noNull(request.getParameter("degree"));
if(degree.equals(""))
	degree=miscUtil.noNull(session.getValue(("degree")));
String branch=miscUtil.noNull(request.getParameter("branch"));
if(branch.equals(""))
	branch=miscUtil.noNull(session.getValue(("branch")));

String sem=miscUtil.noNull(request.getParameter("sem"));
if(sem.equals(""))
	sem=miscUtil.noNull(session.getValue(("sem")));

String reg=miscUtil.noNull(request.getParameter("reg"));
if(reg.equals(""))
	reg=miscUtil.noNull(session.getValue(("reg")));

HashMap electivelist=new HashMap();
electivelist=subdb.getElectiveList(degree, branch, sem, reg);
session.putValue("electives", electivelist);

%>

											<option value="" selected>-</option>
								<%
									   Set<String> keys=electivelist.keySet();
										for(String key:keys)
										{
								%>
										<option value='<%=key %>'><%=key %> </option>
								<%
											
								} 
										
									%>
	
