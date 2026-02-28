<%@ page import="com.mvc.model.User" %>
<%
    User user = (User) request.getAttribute("user");
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">Edit User</h4>
                </div>

                <div class="card-body">
                    <form action="<%=request.getContextPath()%>/users" method="post">

                        <!-- Hidden fields to tell servlet it's an update -->
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="userId" value="<%=user.getUserId()%>"/>

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" name="name" class="form-control" 
                                   value="<%=user.getName()%>" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" 
                                   value="<%=user.getEmail()%>" required>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="text" name="phone" class="form-control" 
                                   value="<%=user.getPhone()%>">
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" 
                                   value="<%=user.getPassword()%>" required>
                        </div>

                        <!-- Role -->
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select name="role" class="form-select" required>
                                <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
                                <option value="user" <%= "user".equals(user.getRole()) ? "selected" : "" %>>User</option>
                            </select>
                        </div>

                        <!-- Buttons -->
                        <div class="d-flex justify-content-end gap-2">
                            <a href="<%=request.getContextPath()%>/users" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-success">Update User</button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>