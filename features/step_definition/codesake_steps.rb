Given /^the file "([^"]*)" doesn't exist$/ do |file|
  FileUtils.rm(file) if File.exists?(file)
end

Given /^the jsp file "(.*?)" does exist$/ do |file|
jsp_content =<<EOS
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.codesake.test"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/CSS" href="<%=request.getContextPath()%>/css/style.css" />
<title>Hello World</title>

<script type="text/javascript">
	function confirmSubmit(name) {
		return alert("test here'"+ cacheName +"'");
	}
	
	</script>
	
</head>
<body>

<div id="header">
<h1>Hello World</h1>

<a href="<%=request.getContextPath()%>/jsp/link1.jsp">Link 1</a>
<a href="<%=request.getContextPath()%>/jsp/link2.jsp">Link 2</a>
<a href="<%=request.getContextPath()%>/jsp/link3.jsp">Link 3</a>
<a href="<%=request.getContextPath()%>/jsp/link4.jsp">Link 4</a>
<a href="<%=request.getContextPath()%>/servlet">servlet</a>
</div>

<%
 String message = (String) request.getAttribute("message");
 if(message != null)
 {
%>
<h4 id="message"><%=message%></h4>
<% }
else
{
 %>
 <h4 id="message"></h4>
<% } %>
<div id="content">
<form action="<%=request.getContextPath()%>/postHandler" method="post">
<label for="message">message:</label>
<input type="text" name="message" id="message" size="40" value="<%=request.getLocalName()%>"  />
<input type="submit" value="submit" onclick="javascript: return confirmSubmit('Clienti');" />
</form>
</div>
</body>
EOS

FileUtils.rm(file) if File.exists?(file)
File.open(file, "w") do |f|
  f.write(jsp_content)
end

end

Given /^we add "(.*?)" as reserved word$/ do |key|
  @keywords = key
end

Given /^the text file "([^"]*)" does exist$/ do |file|
  FileUtils.rm(file) if File.exists?(file)
lorem_ipsum = <<EOS
Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh
euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim
ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl
ut aliquip ex ea commodo consequat. Duis splople autem vel eum iriure dolor in
hendrerit in vulputate velit esse password molestie consequat, vel illum dolore eu
feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui
blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla
facilisi.

Pellentesque at dolor non lectus sagittis semper. Donec quis mi. Duis eget
pede. Phasellus arcu tellus, ultricies id, consequat id, lobortis nec, diam.
Suspendisse sed nunc. Pellentesque id magna. Morbi interdum quam at est.
Maecenas eleifend mi in urna. Praesent et lectus ac nibh luctus viverra. In vel
dolor sed nibh sollicitudin tincidunt. Ut consequat nisi sit amet nibh. Nunc mi
tortor, tristique sit amet, rhoncus porta, malesuada elementum, nisi. Integer
vitae enim quis risus aliquet gravida. Curabitur vel lorem vel erat dapibus
lobortis. Donec secret dignissim tellus at arcu. Quisque molestie pulvinar sem.

Nulla magna neque, ullamcorper tempus, luctus eget, malesuada ut, velit. Morbi
felis. Praesent in purus at ipsum cursus posuere. Morbi bibendum facilisis
eros. Phasellus aliquam password sapien in erat. Praesent venenatis diam dignissim dui.
Praesent risus erat, iaculis ac, dapibus sed, imperdiet ac, erat. Nullam sed
ipsum. Phasellus non dolor. Donec ut elit.
EOS

  File.open(file, "w") do |f|
    f.write(lorem_ipsum)
  end
end

Given /^the jsp file "(.*?)" with cookies does exist$/ do |file|

jsp_content =<<EOS
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.codesake.test"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/CSS" href="<%=request.getContextPath()%>/css/style.css" />
<title>Hello World</title>

<script type="text/javascript">
	function confirmSubmit(name) {
		return alert("test here'"+ cacheName +"'");
	}
	
	</script>
	
</head>
<body>

<div id="header">
<h1>Hello World</h1>

<a href="<%=request.getContextPath()%>/jsp/link1.jsp">Link 1</a>
<a href="<%=request.getContextPath()%>/jsp/link2.jsp">Link 2</a>
<a href="<%=request.getContextPath()%>/jsp/link3.jsp">Link 3</a>
<a href="<%=request.getContextPath()%>/jsp/link4.jsp">Link 4</a>
<a href="<%=request.getContextPath()%>/servlet">servlet</a>
</div>

<%
 String message = (String) request.getAttribute("message");
 if(message != null)
 {
%>
<h4 id="message"><%=message%></h4>
<% }
else
{
 %>
 <h4 id="message"></h4>
<% } %>
<div id="content">
<form action="<%=request.getContextPath()%>/postHandler" method="post">
<label for="message">message:</label>
<input type="text" name="message" id="message" size="40" value="<%=request.getLocalName()%>"  />
<input type="submit" value="submit" onclick="javascript: return confirmSubmit('Clienti');" />
</form>
</div>
<%
    Cookie c = new Cookie("name", "a_value")
    Cookie cc = new Cookie("second", 12)
%>
</body>
EOS
  File.open(file, "w") do |f|
    f.write(jsp_content)
  end
end
