<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="css/css.css" media="all">
<script src="js/jquery-3.0.0.min.js"></script>
<html>

<head>
    <title>Анализ ссылок</title>
    <!--Скрипт waitingBox-->
    <script>
        $(window).on('load', function() {
        $('.preloader').fadeOut().end();
        });
    </script>
</head>

<body>

    <div class="preloader">
        Loading..
        <div class="preloader__row">
            <div class="preloader__item"></div>
            <div class="preloader__item"></div>
        </div>
    </div>

<!--Создание таблиц, отправка и получение ссылок-->
<form action = "/analyze"  method = "GET">

    <table class="table" >
        <tr>
            <td><b>Address</b></td>
            <td><input type = "url" name = "link" class="inp" id="input"
                       size = "70" required/></td>
        </tr>
    </table>
    <tr>
    <td >
        <div class = "Center">
        <input type = "submit" value  = "Анализировать" />
        </div>
    </td>
    </tr>

    <table   border="0" cellpadding="0" cellspacing="0" id="tb">
        <tr>
        <thead>
        <tr>
            <td align="left">
               <b>Обнаруженные ссылки</b>
            </td>
        </tr>
        </thead>
            <td>
                <table border="1">
                    <thead>
                    <tr>
                        <th scope="col" class="col1">№</th>
                        <th scope="col" class="col2">Имя ссылки</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="textList" items="${text}" varStatus="status">
                            <tr>
                                <th scope="row" height="45">${status.count}</th>
                                <td height="45"><p>${textList}</p></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </td>
            <td valign="top">
                <table border="1">
                    <thead>
                    <tr>
                        <th scope="col" class="col3">Адрес ссылки</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="linkList" items="${link}">
                        <tr>
                            <td height="45"><a style=" cursor:pointer" id="ref" class="reference">${linkList}</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>


</form>
    <div class = "Center">
        <button class="button">Очистить</button>
    </div>
    <!--Скрипт удаления таблицы-->
    <script  type="text/javascript">
        $(".button").click(function(){
            $("#tb tbody tr").remove();
        });
    </script>
    <!--Скрипт реализующий подстановку ссылки из 3его поля в поле для анализа-->
    <script  type="text/javascript">
            $(".reference").click(function(){
                var elem = this.innerText;
                document.getElementById("input").setAttribute("value",elem);
            });
    </script>
</body>
</html>