<%@ Page Language="C#"%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
</head>
<body>
<%
    Response.Write(Request.Form["competitorList"]);
%>

</body>
</html>
