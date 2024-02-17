
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

String reg=miscUtil.noNull(request.getParameter("reg"));
if(reg.equals(""))
	reg=miscUtil.noNull(session.getValue(("reg")));


//System.out.println(selele);
//System.out.println(subjectsList);
ArrayList slist=new SubjectDB().getLabSubjectsList(degree, branch, sem, reg);
session.putValue("subjects", slist);
%>
                          <% 
							out.println("<option value='' selected>-</option>");
							
							for(int i=0;i<slist.size();i++)
							{
								Subject sub=(Subject)slist.get(i);
								
						   String code=sub.getCode();
						   String name=sub.getSname();
							out.println("<option value='"+code+"'>"+name+"</option>");
								
								
							
							}
							
							%>
							
							
