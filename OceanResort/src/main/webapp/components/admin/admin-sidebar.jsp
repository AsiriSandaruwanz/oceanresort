<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="#" class="brand-link">
      <img src="<%=request.getContextPath()%>/assets/admin/dist/img/AdminLTELogo.png"
           alt="Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">My Admin</span>
    </a>

    <div class="sidebar">
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="<%=request.getContextPath()%>/assets/admin/dist/img/user2-160x160.jpg"
               class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Asiri</a>
          <span class="badge badge-info">Logged in</span>
        </div>
      </div>

          <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item">
             <a href="${pageContext.request.contextPath}/dashboard"
                class="nav-link">
                 <i class="nav-icon fas fa-tachometer-alt"></i>
                 <p>Dashboard</p>
             </a>
          </li>

          
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/users" class="nav-link">
              <i class="nav-icon fas fa-users"></i>
              <p>Users</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/rooms" class="nav-link">
              <i class="nav-icon fas fa-utensils"></i>
              <p>Rooms</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/services" class="nav-link">
              <i class="nav-icon fas fa-concierge-bell"></i>
              <p>Services</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/payments" class="nav-link">
              <i class="nav-icon fas fa-star"></i>
              <p>Payments</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/feedbacks" class="nav-link">
              <i class="nav-icon fas fa-star"></i>
              <p>Feedbacks</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/reservations" class="nav-link">
              <i class="nav-icon fas fa-concierge-bell"></i>
              <p>Reservations</p>
            </a>
          </li>
          
          <li class="nav-item has-treeview 
               ${pageContext.request.requestURI.contains('blogs') || 
                 pageContext.request.requestURI.contains('categories') ? 'menu-open' : ''}">

             <a href="#" class="nav-link 
                 ${pageContext.request.requestURI.contains('blogs') || 
                   pageContext.request.requestURI.contains('categories') ? 'active' : ''}">
        
               <i class="nav-icon fas fa-blog"></i>
               <p>
                 Blogs
                 <i class="right fas fa-angle-left"></i>
               </p>
             </a>

             <ul class="nav nav-treeview">
           
               <!-- All Blogs -->
               <li class="nav-item">
                 <a href="${pageContext.request.contextPath}/blogs"
                    class="nav-link ${pageContext.request.requestURI.contains('/blogs') ? 'active' : ''}">
                   <i class="far fa-circle nav-icon"></i>
                   <p>All Blogs</p>
                 </a>
               </li>

               <!-- Blog Categories -->
               <li class="nav-item">
                 <a href="${pageContext.request.contextPath}/blog-categories"
                    class="nav-link ${pageContext.request.requestURI.contains('blog-categories') ? 'active' : ''}">
                   <i class="far fa-circle nav-icon"></i>
                   <p>Blog Categories</p>
                 </a>
               </li>
           
             </ul>
          </li>
          
        
          
          <li class="nav-item mt-4">
            <a href="<%=request.getContextPath()%>/logout" class="nav-link text-danger">
              <i class="nav-icon fas fa-sign-out-alt"></i>
              <p>Sign Out</p>
            </a>
          </li>
         
        </ul>
      </nav>
    </div>
  </aside>