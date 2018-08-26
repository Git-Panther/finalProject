<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/header.do"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <link href='resources/css/fullcalendar.min.css' rel='stylesheet'/>
    <link href='resources/css/fullcalendar.print.min.css' rel='stylesheet' media='print'/>
    <script type="text/javascript" src="resources/js/moment.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="resources/js/fullcalendar.min.js"></script>
    <script type="text/javascript" src="resources/js/plan.js"></script>
    <script type="text/javascript" src="resources/js/locale-all.js"></script>
    <script type="text/javascript" src="resources/js/ko.js"></script>
    <script type="text/javascript" src="resources/js/gcal.js"></script>
    <script type="text/javascript" src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

   <style>
        body {
            background-color: #F5FDFD;
            margin-top: 40px;
            text-align: center;
            font-size: 14px;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
        }

        #wrap {
            width: 1100px;
            margin: 0 auto;
        }

        #external-events {
            width: 150px;
            padding: 0 10px;
            border: 1px solid #ccc;
            background: #eee;
            text-align: left;
        }

        #external-events h4 {
            font-size: 16px;
            margin-top: 0;
            padding-top: 1em;
        }

        #external-events .fc-event {
            margin: 10px 0;
            cursor: pointer;
        }

        #external-events p {
            margin: 1.5em 0;
            font-size: 11px;
            color: #666;
        }

        #external-events p input {
            margin: 0;
            vertical-align: middle;
        }

        #calendar {
            float: right;
            width: 900px;
        }
        .fc-sun {
            color: red;
        }
        .fc-sat {
            color: blue;
        }

    </style>
    <script type="text/javascript">

        /* IMPORTANT: Put script after tooltip div or
             put tooltip div just before </BODY>. */

        var dom = !!(document.getElementById);
        var ns5 = !!(!document.all && dom || window.opera);
        var ie5 = ((navigator.userAgent.indexOf("MSIE") > -1) && dom);
        var ie4 = !!(document.all && !dom);
        var nodyn = (!ns5 && !ie4 && !ie5 && !dom);

        var origWidth, origHeight;

        // avoid error of passing event object in older browsers
        if (nodyn) { event = "nope" }

        ///////////////////////  CUSTOMIZE HERE   ////////////////////
        // settings for tooltip
        // Do you want tip to move when mouse moves over link?
        var tipFollowMouse= true;
        // Be sure to set tipWidth wide enough for widest image
        var tipWidth= "auto";
        var offX= 20;	// how far from mouse to show tip
        var offY= 12;
        var tipFontFamily= "Verdana, arial, helvetica, sans-serif";
        var tipFontSize= "8pt";
        // set default text color and background color for tooltip here
        // individual tooltips can have their own (set in messages arrays)
        // but don't have to
        var tipFontColor= "#000000";
        var tipBgColor= "#DDECFF";
        var tipBorderColor= "#000080";
        var tipBorderWidth= 3;
        var tipBorderStyle= "ridge";
        var tipPadding= 4;

        // tooltip content goes here (image, description, optional bgColor, optional textcolor)
        var messages = [];

        /*
        messages[0] = ['data:image/jpeg;base64,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','축제 기간 : 2018-08-08',"#FFFFFF"];
        messages[1] = ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqVZTpwYueLhCilvi3ADMTK0NV4jCC0VvoT6IkgOGIUcGrO-ZBnA','',"#FFFFFF"];
        messages[2] = ['test.gif','Test description','black','white'];
        */
        ////////////////////  END OF CUSTOMIZATION AREA  ///////////////////

        // preload images that are to appear in tooltip
        // from arrays above
        if (document.images) {
            var theImgs = [];
            for (var i=0; i<messages.length; i++) {
                theImgs[i] = new Image();
                theImgs[i].src = messages[i][0];
            }
        }

        // to layout image and text, 2-row table, image centered in top cell
        // these go in var tip in doTooltip function
        // startStr goes before image, midStr goes between image and text
        var startStr = '<table width="' + tipWidth + '"><tr><td align="center" width="100%"><img src="';
        var midStr = '" border="0"></td></tr><tr><td valign="top">';
        var endStr = '</td></tr></table>';

        /////////////////////////////////////////
        //initTip - initialization for tooltip.//
        /////////////////////////////////////////
        var tooltip, tipcss;
        function initTip() {
            if (nodyn) return;
            tooltip = (ie4)? document.all['tipDiv']: (ie5||ns5)? document.getElementById('tipDiv'): null;
            tipcss = tooltip.style;
            if (ie4||ie5||ns5) {	// ns4 would lose all this on rewrites
                tipcss.width = tipWidth;
                tipcss.fontFamily = tipFontFamily;
                tipcss.fontSize = tipFontSize;
                tipcss.color = tipFontColor;
                tipcss.backgroundColor = tipBgColor;
                tipcss.borderColor = tipBorderColor;
                tipcss.borderWidth = tipBorderWidth+"px";
                tipcss.padding = tipPadding+"px";
                tipcss.borderStyle = tipBorderStyle;
            }
            if (tooltip&&tipFollowMouse) {
                document.onmousemove = trackMouse;
            }
        }

        window.onload = initTip;

        //////////////////////
        //doTooltip function//
        //////////////////////
        var t1,t2;	// for setTimeouts
        var tipOn = false;	// check if over tooltip link
        function doTooltip(evt,num) {
            if (!tooltip) return;
            if (t1) clearTimeout(t1);	if (t2) clearTimeout(t2);
            tipOn = true;
            // set colors if included in messages array
            if (messages[num][2])	var curBgColor = messages[num][2];
            else curBgColor = tipBgColor;
            if (messages[num][3])	var curFontColor = messages[num][3];
            else curFontColor = tipFontColor;
            if (ie4||ie5||ns5) {
                var tip = startStr + messages[num][0] + midStr + '<span style="font-family:' + tipFontFamily + '; font-size:' + tipFontSize + '; color:' + curFontColor + ';">' + messages[num][1] + '</span>' + endStr;
                tipcss.backgroundColor = curBgColor;
                tooltip.innerHTML = tip;
            }
            if (!tipFollowMouse) positionTip(evt);
            else t1=setTimeout("tipcss.visibility='visible'",100);
        }

        var mouseX, mouseY;
        function trackMouse(evt) {
            standardbody=(document.compatMode==="CSS1Compat")? document.documentElement : document.body; //create reference to common "body" across doctypes
            mouseX = (ns5)? evt.pageX: window.event.clientX + standardbody.scrollLeft;
            mouseY = (ns5)? evt.pageY: window.event.clientY + standardbody.scrollTop;
            if (tipOn) positionTip(evt);
        }

        ////////////////////////
        //positionTip function//
        ////////////////////////
        function positionTip(evt) {
            if (!tipFollowMouse) {
                standardbody=(document.compatMode==="CSS1Compat")? document.documentElement : document.body;
                mouseX = (ns5)? evt.pageX: window.event.clientX + standardbody.scrollLeft;
                mouseY = (ns5)? evt.pageY: window.event.clientY + standardbody.scrollTop;
            }
            // tooltip width and height
            var tpWd = (ie4||ie5)? tooltip.clientWidth: tooltip.offsetWidth;
            var tpHt = (ie4||ie5)? tooltip.clientHeight: tooltip.offsetHeight;
            // document area in view (subtract scrollbar width for ns)
            var winWd = (ns5)? window.innerWidth-20+window.pageXOffset: standardbody.clientWidth+standardbody.scrollLeft;
            var winHt = (ns5)? window.innerHeight-20+window.pageYOffset: standardbody.clientHeight+standardbody.scrollTop;
            // check mouse position against tip and window dimensions
            // and position the tooltip
            if ((mouseX+offX+tpWd)>winWd)
                tipcss.left = mouseX-(tpWd+offX)+"px";
            else tipcss.left = mouseX+offX+"px";
            if ((mouseY+offY+tpHt)>winHt)
                tipcss.top = winHt-(tpHt+offY)+"px";
            else tipcss.top = mouseY+offY+"px";
            if (!tipFollowMouse) t1=setTimeout("tipcss.visibility='visible'",100);
        }

        function hideTip() {
            if (!tooltip) return;
            t2=setTimeout("tipcss.visibility='hidden'",100);
            tipOn = false;
        }

        document.write('<div id="tipDiv" style="position:absolute; visibility:hidden; z-index:100"></div>')

    </script>

    <style>
        .fc-state-default{
            background-color: #fff;
        }

        .fc-unthemed .fc-content, .fc-unthemed .fc-divider, .fc-unthemed .fc-list-heading td, .fc-unthemed .fc-list-view, .fc-unthemed .fc-popover, .fc-unthemed .fc-row, .fc-unthemed tbody, .fc-unthemed td, .fc-unthemed th, .fc-unthemed thead{
            border-color: #1ec0ff;
        }
        .btn{
            display: inline-block;
            text-decoration: none;
            border: 1px solid #49b2e9;
            color: #ffffff;
            text-align: center;
            line-height: 38px;
            border-radius: 100px;
            padding: 0 22px;
            -webkit-transition: all 0.3s;
            transition: all 0.3s;
            background: #49b2e9;
            width: 120px;
            margin-right: 40px;
            cursor: pointer;
        }

        .btn:hover {
            box-shadow: 0 2px 4px #49b2e9;
        }

        #external-events{
            margin-top: 200px;
            background-color: #F5FDFD;
            border-color: #1ec0ff;
        }
        .fc-toolbar h2{
            font-size: 30px;
        }
        .fc-event, .fc-event-dot{
            background-color: #ffffff;
        }
        .fc-event, .fc-event:hover{
            color: #ffffff;
        }
        .fc-event{
            border: 1px solid #f9a11b;
            background-color: #f9a11b;
        }

    </style>
</head>
<body>
<div id='wrap'>
    <div style="float: left; width: 200px">
        <div id='external-events'>
            <h4>Drag Festival</h4>
                <div id="favoriteFestivals" onmouseover="doTooltip(event,0)" onmouseout="hideTip()">
                </div>
        </div>
        <br/>
        <form><input class="btn" type="button" value="다시 만들기" onClick="window.location.reload()"></form>
        <br/>
        <br/>
        <button class="btn">저장</button>

    </div>

    <div id='calendar'></div>

    <div style='clear:both'></div>

</div>
<c:import url="/footer.do"/>
</body>
</html>