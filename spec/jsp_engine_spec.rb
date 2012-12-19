require 'spec_helper'

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

describe Codesake::Engine::Jsp do
  before(:all) do
    File.open("test.jsp", "w") do |f|
      f.write(jsp_content)
    end
    @jsp = Codesake::Engine::Jsp.new("test.jsp")
    @jsp.analyse
  end

  after(:all) do
    File.delete("test.jsp") if File.exists?("test.jsp")
  end

  it_behaves_like Codesake::Utils::Files
  # it_behaves_like Codesake::Utils::Secrets
  it_behaves_like Codesake::Engine::Core

  it "takes a filename as input" do
    @jsp.filename.should_not be_nil
    @jsp.filename.should_not be_empty
  end

  it "analyses a jsp for imported packages" do
    expected_result = [{:package=>"com.codesake.test", :line=>3}]
    @jsp.imports.should == expected_result
  end

  it "analyses a jsp file for attack entrypoints" do
    expexted_result = [{:line=>32, :param=>"message", :var=>"message"}]
    @jsp.attack_entrypoints.should == expexted_result
  end
  it "analyses a jsp file for reflected variables" do
    expexted_result = [{:line=>8, :var=>"request.getContextPath()", :false_positive=>true}, 
      {:line=>24, :var=>"request.getContextPath()", :false_positive=>true},
      {:line=>25, :var=>"request.getContextPath()", :false_positive=>true},
      {:line=>26, :var=>"request.getContextPath()", :false_positive=>true},
      {:line=>27, :var=>"request.getContextPath()", :false_positive=>true},
      {:line=>28, :var=>"request.getContextPath()", :false_positive=>true},
      {:line=>36, :var=>"message", :false_positive=>false},
      {:line=>44, :var=>"request.getContextPath()", :false_positive=>true},
      {:line=>46, :var=>"request.getLocalName()", :false_positive=>true}
    ]
    @jsp.reflected_xss.should == expexted_result
  end


 


end
