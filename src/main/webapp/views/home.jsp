<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>BeeNatural</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>
    <div class="centered">
        <img src="${pageContext.request.contextPath}/images/loghi/Logo.jpeg" alt="Logo BeeNatural">
        <h1>BeeNatural</h1>
        <form action="${pageContext.request.contextPath}/views/login.jsp">
    		<button type="submit" class="btn-accedi">Accedi</button>
		</form>
    </div>
</body>
</html>