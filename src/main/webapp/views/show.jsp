<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--万能前缀 可以直接找到路径--%>
<% String path=request.getContextPath();
   String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
<html>
<head>
    <title>项目进度管理系统</title>
</head>
 <!-- 1.引入相关的js和css, 例如甘特图模板-->
  <script type="text/javascript" src="<%=basePath%>static/jquery/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="<%=basePath %>static/bootstrap/js/bootstrap.js"></script>
  <script  type="text/javascript" src="<%=basePath%>static/bootstrap/js/bootstrap-treeview.js"></script>

<!-- 2.处理业务逻辑的js等 -->
 <script type="text/javascript" src="<%=basePath%>static/gantt-6.0.4/codebase/dhtmlxgantt.js"></script>
<%--下面导入的这个js是可以直接国际化的--%>
 <script type="text/javascript" src="<%=basePath%>static/gantt-6.0.4/codebase/locale/locale_cn.js"></script>
<script type="text/javascript" src="<%=basePath%>static/gantt-6.0.4/codebase/ext/dhtmlxgantt_marker.js"></script>
<script type="text/javascript" src="<%=basePath%>static/gantt-6.0.4/codebase/ext/dhtmlxgantt_tooltip.js"></script>
<script type="text/javascript" src="<%=basePath%>static/gantt-6.0.4/codebase/ext/dhtmlxgantt_undo.js"></script>
<script type="text/javascript" src="<%=basePath%>static/gantt-6.0.4/codebase/api.js"></script>
<!-- 引入对于的css-->
 <link rel="stylesheet" type="text/css" href="<%=basePath%>static/bootstrap/css/bootstrap.css">
 <link rel="stylesheet" type="text/css" href="<%=basePath%>static/bootstrap/css/bootstrap-treeview.css">
 <link rel="stylesheet" type="text/css" href="<%=basePath%>static/gantt-6.0.4/codebase/dhtmlxgantt.css">
<!--3.展示 -->
<body>
     <div class="webapp-title">
           <ul class="webapp side">

           </ul>

         <input value="导出PDF" type="button" class="btn btn-warning" onclick="gantt.exportToPDF()">
         <input  value="导出图片" type="button" class="btn btn-success" onclick="gantt.exportToPNG()">
         <input value="导出Excel" type="button" class="btn btn-danger" onclick="gantt.exportToExcel()">
     </div>
     <div class="panel panel-default">
         <div class="panel-heading">
             <h3>项目进度管理系统</h3>
         </div>
         <div class="panel-body">
              <div id="gantt_here" style="height: 400px;"></div>
         </div>

     </div>
</body>
<script type="text/javascript">
    var tasks={
       data:[
           {"id":21,"text":"全球项目","start_date":"01-01-2018","end_date":"02-01-2018","duration":6,"progress":0.5,open:true},
           {"id":22,"text":"东北区项目","start_date":"01-01-2018","end_date":"01-02-2018","duration":6,"progress":0.5,"parent":21,open:true},
           {"id":23,"text":"西南区项目","start_date":"01-01-2018","end_date":"22-01-2018","duration":6,"progress":0.2,"parent":21,open:true},
           {"id":24,"text":"西北区项目","start_date":"01-01-2018","end_date":"12-01-2018","duration":6,"progress":0.8,"parent":21,open:true},
           {"id":25,"text":"东南区项目","start_date":"01-01-2018","end_date":"30-01-2018","duration":6,"progress":0.1,"parent":21,open:true},
           {"id":26,"text":"澳门区项目","start_date":"01-01-2018","end_date":"16-01-2018","duration":6,"progress":0.2,"parent":21,open:true},
           {"id":27,"text":"日本区项目","start_date":"01-01-2018","end_date":"30-01-2018","duration":6,"progress":1,"parent":30,open:true},
           {"id":28,"text":"韩国区项目","start_date":"01-01-2018","end_date":"30-01-2018","duration":6,"progress":0.8,"parent":30,open:true},
           {"id":29,"text":"欧美区项目","start_date":"01-01-2018","end_date":"30-01-2018","duration":6,"progress":0.9,"parent":21,open:true},
           {"id":30,"text":"亚洲项目","start_date":"01-01-2018","end_date":"30-01-2018","duration":6,"progress":0.2,"parent":21,open:true}
       ],
        links:[
            {"id":21,"source":21,"target":22,"type":"0"},
            {"id":22,"source":21,"target":23,"type":"0"},
            {"id":23,"source":22,"target":24,"type":"1"},
            {"id":24,"source":23,"target":25,"type":"2"},
            {"id":25,"source":23,"target":25,"type":"0"},
            {"id":26,"source":21,"target":29,"type":"0"},
            {"id":27,"source":23,"target":27,"type":"0"},
            {"id":28,"source":21,"target":26,"type":"0"},
            {"id":29,"source":23,"target":26,"type":"0"},
            {"id":30,"source":21,"target":30,"type":"0"}
        ]
        /*
         * data中的 id :任务id， text:任务描述 ,start_date:开始时间 ，end_date:结束时间，duration：在当前刻度下任务的持续周期
         *          parent :：父任务的Id
         */
        /*
         *links中的id：关联线的id，source：数据源任务的id，target:目标源任务的id，
         * type: 0  ---  从结束到开始
         * type:   1  ---  开始到开始
         * type:   2  ---- 结束到结束
         */

    }
    gantt.init("gantt_here");
    //gantt.parse(tasks);
    gantt.load("../getData");

    // 添加进 任务项目 mysql
    gantt.attachEvent("onAfterTaskAdd",function(id,item){
        var formatFunc = gantt.date.date_to_str("%d-%m-%Y");
        var start_date = formatFunc(item.start_date);
        var end_date = formatFunc(item.end_date);
       /* item.start_date=start_date;
        item.end_date=end_date;*/
         $.ajax({
           type:"post",
           url:"../doAdd?start_date="+start_date+"&end_date="+end_date,
           data:item,
           success:function (res) {
               if(res==1) {
                   alert("添加成功！");
                   return false;//toastr.success("添加成功！");

               }else {
                   alert("添加失败！");//toastr.success("添加成功！");

               }
           }

           })
    });
     // 更新进 任务项目 mysql
    gantt.attachEvent("onAfterTaskUpdate",function(id,item){
        var formatFunc = gantt.date.date_to_str("%d-%m-%Y");
        var start_date = formatFunc(item.start_date);
        var end_date = formatFunc(item.end_date);
        /* item.start_date=start_date;
         item.end_date=end_date;*/
        $.ajax({
            type:"post",
            url:"../doUpdate?start_date="+start_date+"&end_date="+end_date,
            data:item,
            success:function (res) {
                if(res==1) {
                    alert("更新成功！");
                    return false;//toastr.success("添加成功！");

                }else {
                    alert("更新失败！");//toastr.success("添加成功！");

                }
            }

        })
    });
    // 删除 任务项目 mysql
    gantt.attachEvent("onAfterTaskDelete",function(id,item){

        $.ajax({
            type:"get",
            url:"../doDelete?id="+id,
            data:{},
            success:function (res) {
                if(res==1) {
                    alert("删除成功！");
                    return false;//toastr.success("添加成功！");

                }else {
                    alert("删除失败！");//toastr.success("添加成功！");

                }
            }

        })
    });
    // 添加关系到mysql
    gantt.attachEvent("onAfterLinkAdd",function(id,item){

        $.ajax({
            type:"post",
            url:"../doAddLink",
            data:item,
            success:function (res) {
                if(res==1) {
                    alert("添加成功！");
                    return false;//toastr.success("添加成功！");

                }else {
                    alert("添加失败！");//toastr.success("添加成功！");

                }
            }

        })
    });

    // 更新关系到mysql
    gantt.attachEvent("onAfterLinkUpdate",function(id,item){

        $.ajax({
            type:"post",
            url:"../doUpdateLink",
            data:item,
            success:function (res) {
                if(res==1) {
                    alert("更新成功！");
                    return false;//toastr.success("添加成功！");

                }else {
                    alert("更新失败！");//toastr.success("添加成功！");

                }
            }

        })
    });

    // 删除关系到mysql
    gantt.attachEvent("onAfterLinkDelete",function(id,item){

        $.ajax({
            type:"post",
            url:"../doDeleteLink?id="+id,
            data:item,
            success:function (res) {
                if(res==1) {
                    alert("删除成功！");
                    return false;//toastr.success("添加成功！");

                }else {
                    alert("删除失败！");//toastr.success("添加成功！");

                }
            }

        })
    });
</script>
</html>
