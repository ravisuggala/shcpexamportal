
<%@ page import = "java.util.*,dao.*" %>
<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />
<jsp:useBean id = "subdb" scope="session" class="dao.SubjectDB" />
<jsp:useBean id = "stdb" scope="session" class="dao.StudentDB" />

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


<%
String branch=new String();

String sem=new String();

String ay=new String();
String reg=new String();
String degree=new String();
String cat=new String();
String type=new String();
String section=new String();
String elecat="";
String disp="";
ArrayList students=new ArrayList();
ArrayList subjectsList=new ArrayList();
String target=miscUtil.noNull(request.getParameter("hiddenActionType"));
String fe="";
String subject="";
if(target.equals("storemarks"))
{
	degree=session.getValue("degree").toString();
	branch=session.getValue("branch").toString();
	sem=session.getValue("sem").toString();
	//section=session.getValue("section").toString();
	reg=session.getValue("reg").toString();
	ay=session.getValue("ay").toString();
	
	//type=session.getValue("type").toString();	
	students=(ArrayList)session.getValue("students");	
	subjectsList=(ArrayList)session.getValue("subjectslist");
	if(cat.equals("fe"))
		 fe=miscUtil.noNull(session.getValue("fe"));
	
	 subject= miscUtil.noNull(request.getParameter("subject"));
	session.putValue("subject",subject);
	cat=miscUtil.noNull(request.getParameter("cat"));
	session.putValue("cat",cat);
	elecat=miscUtil.noNull(request.getParameter("elecat"));
	session.putValue("elecat",elecat);
	
	
}
else
{
	degree=miscUtil.noNull(request.getParameter("degree"));
	 branch=miscUtil.noNull(request.getParameter("branch"));
	 sem=miscUtil.noNull(request.getParameter("sem"));
	 reg=miscUtil.noNull(request.getParameter("reg"));
	 ay=miscUtil.noNull(request.getParameter("ay"));
	 cat=miscUtil.noNull(request.getParameter("cat"));
	// type=miscUtil.noNull(request.getParameter("type"));
//	 section=miscUtil.noNull(request.getParameter("section"));

     
	 subject= miscUtil.noNull(request.getParameter("subject"));
	 elecat=miscUtil.noNull(request.getParameter("elecat"));
	 students=stdb.getStudentList(degree, branch, sem,section);
	session.putValue("degree",degree);
	session.putValue("branch",branch);
	session.putValue("sem",sem);
	session.putValue("section",section);
	session.putValue("reg",reg);
	session.putValue("ay",ay);
	session.putValue("cat",cat);
	session.putValue("fe",fe);
	//session.putValue("type",type);
	session.putValue("elecat",elecat);
	session.putValue("subject",subject);
	
	
}
	   
	String utype=ur.getStatus();
	boolean freez=false;
	if(!utype.equals("admin"))
		 freez=new MidExamDB().isMidFreeze(sem,degree,ay,type);
	
	if(freez)
	{
		 ServletContext sc = getServletContext();
		    RequestDispatcher rd = sc.getRequestDispatcher("/statusinfo.jsp");
		    request.setAttribute("status", "Mid Marks are freezed for the selected branch and section");
			rd.forward(request, response);
	}

	else
	{
		MidExamDB mdb=new MidExamDB();
		students=mdb.getAbsentStudentList(branch, sem,ay,reg,subject);
		
		session.putValue("students", students);	
	session.putValue("option", "grandteststep2");
	response.sendRedirect("./R18grandtestinput.jsp");
	}
	
		/*if(cat.equals("common"))
	{
//		System.out.println("ififif");
        if(type.equals("L"))
        	subjectsList = subdb.getLabSubjectsList(degree, branch, sem, reg);
        else if(type.equals("S"))
        {
        	String sm=subdb.isContainsSeminar(degree,branch,sem,reg);
        	if(!sm.equals(""))
        	{
        		session.putValue("subject", sm);
        		ArrayList mapids=subdb.getMapIDs(students,sm);
        		session.putValue("mapids", mapids);
        		response.sendRedirect("./seminarmarks.jsp");
        	}
        	else
        	{
        		String error="No Seminar for selected branch and semester";
        		session.putValue("error", error);
        		response.sendRedirect("./errors.jsp");
        	}
        }
        
        else
        	subjectsList = subdb.getSubjectsList(degree, branch, sem, reg);
        
		session.putValue("subjectslist", subjectsList);
	}
	else if(cat.equals("elective"))
	{
		HashMap electivelist=new HashMap();
		electivelist=subdb.getElectiveList(degree, branch, sem, reg);
		session.putValue("electives", electivelist);
		response.sendRedirect("./electivetypes.jsp");
	}
	else if(cat.equals("fe"))
	{
    	subjectsList = subdb.getFEList(degree, branch, sem, reg,fe);
		session.putValue("subjectslist", subjectsList);
	
	}
*/
	//System.out.println("in else");
	



	
%>

	</body>
</html>
