
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

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

String section=miscUtil.noNull(request.getParameter("section"));
if(section.equals(""))
	section=miscUtil.noNull(session.getValue(("section")));

String ay=miscUtil.noNull(request.getParameter("ay"));
if(ay.equals(""))
	ay=miscUtil.noNull(session.getValue(("ay")));
String faculty=miscUtil.noNull(request.getParameter("faculty"));
if(faculty.equals(""))
	faculty=miscUtil.noNull(session.getValue(("faculty")));
String reg=miscUtil.noNull(request.getParameter("reg"));
if(reg.equals(""))
	reg=miscUtil.noNull(session.getValue(("reg")));



//System.out.println(selele);
//System.out.println(subjectsList);
ArrayList slist=new FacultyDB().getMappedLabList(degree, branch, sem,ay,section,faculty,reg );

%>
                          <% 
							out.println("<option value='' selected>-</option>");
							
							for(int i=0;i<slist.size();i++)
							{
								FacultyMap sub=(FacultyMap)slist.get(i);
							    String code=sub.getSubcode();
						   		String name=sub.getSubname();
								out.println("<option value='"+code+"'>"+name+"</option>");
						  }
							
							%>
							
							
