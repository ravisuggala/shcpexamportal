
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%


String degree="";
String sem="";
String ay="";
String type="";
String reg="";
String yoa="";

degree=request.getParameter("degree");
sem=request.getParameter("sem");
ay=request.getParameter("ay");
type=request.getParameter("type");
reg=request.getParameter("reg");
yoa=request.getParameter("yoa");
	

 
//System.out.println(selele);
//System.out.println(subjectsList);
ExternalExamDB eedb=new ExternalExamDB();
//type=miscUtil.getExamType(type);
ArrayList slist=eedb.getExamsList(degree, sem, ay, reg, type, yoa);


%>
                          <% 
							out.println("<option value='' selected></option>");
							
							for(int i=0;i<slist.size();i++)
							{
								ExternalExam sub=(ExternalExam)slist.get(i);
								
						   String code=sub.getCode();
						   String name=sub.getDescription();
							out.println("<option value='"+code+"'>"+name+"</option>");
								
								
							
							}
							
							%>
							
							
