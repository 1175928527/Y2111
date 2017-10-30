<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
   <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=f51d42ccbd36ad048bb72860b9f98f85"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<style type="text/css">
	body,html,#container{
		height: 100%;
		margin: 0px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
<div id='container'></div>
<div id="tip"></div>
<script type="text/javascript">
/***************************************
由于Chrome、IOS10等已不再支持非安全域的浏览器定位请求，为保证定位成功率和精度，请尽快升级您的站点到HTTPS。
***************************************/
    var map, geolocation;
    //加载地图，调用浏览器定位服务
    map = new AMap.Map('container', {
        resizeEnable: true
    });
    map.plugin('AMap.Geolocation', function() {
        geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,//是否使用高精度定位，默认:true
            timeout: 10000,          //超过10秒后停止定位，默认：无穷大
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            zoomToAccuracy: true,      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
            buttonPosition:'RB'
        });
        map.addControl(geolocation);
        geolocation.getCurrentPosition();
        AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
        AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息
    });
    //解析定位结果
    function onComplete(data) {
        var str=['定位成功'];
        str.push('经度：' + data.position.getLng());
        str.push('纬度：' + data.position.getLat());
        if(data.accuracy){
             str.push('精度：' + data.accuracy + ' 米');
        }//如为IP精确定位结果则没有精度信息
        str.push('是否经过偏移：' + (data.isConverted ? '是' : '否'));
        document.getElementById('tip').innerHTML = str.join('<br>');
    }
    //解析定位错误信息
    function onError(data) {
        document.getElementById('tip').innerHTML = '定位失败';
    }

    var marker = new AMap.Marker({
        map: map,
        icon: "http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png",
        position: [116.26034, 40.13772]
    });
    var lineArr = [
        [116.25034, 40.13772],
        [116.26034, 40.12772],
        [116.27034, 40.13772],
        [116.28034, 40.12772]
    ];
    var circle = new AMap.Circle({
        map: map,
        center: lineArr[0],          //设置线覆盖物路径
		radius: 1500,
        strokeColor: "#3366FF", //边框线颜色
        strokeOpacity: 0.3,       //边框线透明度
        strokeWeight: 3,        //边框线宽
        fillColor: "#FFA500", //填充色
        fillOpacity: 0.35//填充透明度
    });
    var polygonArr = [[116.28034, 40.12772],
        [116.29034, 40.12772],
        [116.28034, 40.11772],
        [116.27034, 40.11772]];
    var polygon = new AMap.Polygon({
        map: map,
        path: polygonArr,//设置多边形边界路径
        strokeColor: "#FF33FF", //线颜色
        strokeOpacity: 0.2, //线透明度
        strokeWeight: 3,    //线宽
        fillColor: "#1791fc", //填充色
        fillOpacity: 0.35//填充透明度
    });
    map.setFitView();
    marker.on('click', function() {
        alert('您点击了点');
    });
    circle.on('click', function() {
        alert('您点击了圆');
    });
    polygon.on('click', function() {
        alert('您点击了面');
    });
</script>
</body>
</html>