<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>测试页面</title>
<meta name="description" content="">
<meta name="keywords" content="">
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha.2/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap4.min.css" rel="stylesheet">


</head>
<body>
<div style="width:50%;height:500px;margin:150px auto  ;background-color: #f4cccc">
<table id="example" class="display" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>Name</th>
        <th>Cellphone</th>
        <th>Position</th>
        <th>Company</th>
        <th>Salary</th>
    </tr>
    </thead>
    <tbody>

    </tbody>
</table>
</div>

<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src=" //cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        refreshDataTable();
    });

 var refreshDataTable=function() {
     var table = $('#example').DataTable({
         //"ajax":"data/tabledata.json",
        // "iDisplayLength": 3,
         "sPaginationType": "full_numbers",
         "bPaginite": true,
         "bInfo": true,
         "bSort": true,
         "processing": false,
         "serverSide": true,
         "sAjaxSource": "http://127.0.0.1/fenye.php",//这个是请求的地址
         "fnServerData": retrieveData

     });
     function retrieveData(url, aoData, fnCallback) {
         $.ajax({
             url: url,//这个就是请求地址对应sAjaxSource
             data : {
                 "aoData" : JSON.stringify(aoData)
             },
             type: 'POST',
             dataType: 'json',
             async: false,
             success: function (result) {

                 //var obj=JSON.parse(result);
                 console.log(result);
                 fnCallback(result);//把返回的数据传给这个方法就可以了,datatable会自动绑定数据的
             },
             error:function(XMLHttpRequest, textStatus, errorThrown) {

                 console.log("status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus);

             }
         });
     }
 };
</script>
</body>
</html>