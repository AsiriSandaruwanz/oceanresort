<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%><!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Simple Admin Dashboard</title>

  <!-- Google Font -->
  <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">

  <!-- Font Awesome -->
  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/admin/plugins/fontawesome-free/css/all.min.css">

  <!-- AdminLTE -->
  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/admin/dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">

<div class="wrapper">

  <jsp:include page="/components/admin/admin-navbar.jsp" />

  <!-- SIDEBAR -->
  <jsp:include page="/components/admin/admin-sidebar.jsp" />

  <!-- CONTENT -->
  <div class="content-wrapper">
     <!-- Yield Content Here -->
      <jsp:include page="${contentPage}" />
  </div>

  <jsp:include page="/components/admin/admin-footer.jsp" />
</div>

<!-- jQuery -->
<script src="<%=request.getContextPath()%>/assets/admin/plugins/jquery/jquery.min.js"></script>
<!-- AdminLTE -->
<script src="<%=request.getContextPath()%>/assets/admin/dist/js/adminlte.js"></script>

</body>
</html>

