
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%


String exam="";
String regdno="";

exam=request.getParameter("exam");
regdno=request.getParameter("regdno");
	
session.setAttribute("exam", exam);
session.setAttribute("regdno", regdno);
 
//System.out.println(selele);
//System.out.println(subjectsList);
ExternalExamDB eedb=new ExternalExamDB();
ArrayList slist=eedb.getRegisteredSubjects(exam, regdno);



%>
                          <% 
							out.println("<option value='' selected></option>");
							
							for(int i=0;i<slist.size();i++)
							{
								String sub=slist.get(i).toString();
								
						   String code=sub;
						   String reg=new StudentDB().getRegulationForStudent(regdno);
						   String branch=new StudentDB().getBranch(regdno);
						   String name=new SubjectDB().getSubjectTitle(code, reg, branch);
						   String desc=code+"-"+name;
							out.println("<option value='"+code+"'>"+desc+"</option>");
							}
							
							%>
							
							
