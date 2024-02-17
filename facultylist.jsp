
<%@ page import = "java.util.*,dao.*" %>

<jsp:useBean id = "miscUtil" scope="session" class="dao.FBSMiscUtilitiesBean" />
<jsp:useBean id = "fetchData" scope="session" class="dao.FBSFetchDataBean" />

<%



String dept=miscUtil.noNull(request.getParameter("dept"));


//System.out.println(selele);
//System.out.println(subjectsList);
ArrayList slist=new FacultyDB().getFacultyList(dept);

%>
                          <% 
							out.println("<option value='' selected>Select Faculty</option>");
							
							for(int i=0;i<slist.size();i++)
							{
								Faculty sub=(Faculty)slist.get(i);
								
						   String code=sub.getFid();
						   String name=sub.getFname();
							out.println("<option value='"+code+"'>"+name+"</option>");
								
								
							
							}
							
							%>
							
							
