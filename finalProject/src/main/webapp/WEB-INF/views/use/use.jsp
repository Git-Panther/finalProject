<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do"/>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/master.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>페스티벌 플래너</title>
<style>
/*====================*/
/* reset.css */
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}
table {
    border-collapse: collapse;
    border-spacing: 0;
}
/*====================*/
section {max-width:960px; margin:30px auto; padding:30px;}
table {
    width: 100%;
}
th, td {
    padding: 10px;
    border: 1px solid #ddd;
}
th {
    background: #f4f4f4;
}
.demo01 th {
    width: 30%;
    text-align: left;
}

@media only screen and (max-width:768px) {
.demo01 {
    margin: 0 -10px;
}
.demo01 th,  .demo01 td {
    width: 100%;
    display: block;
    border-top: none;
}
.demo01 tr:first-child th {
    border-top: 1px solid #ddd;
}
}
</style>
<body>

<section>
  <table class="demo01">
    <tr>
      <th>축제/행사</th>
      <td>축제/행사 페이지는...</td>
    </tr>
    <tr>
      <th>여행지</th>
      <td>여행지...</td>
    </tr>
  </table>
</section>
	<c:import url="/footer.do"/>
</body>

</html>