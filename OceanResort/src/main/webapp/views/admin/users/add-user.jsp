<%@ page import="com.mvc.model.User" %>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">Add New User</h4>
                </div>

                <div class="card-body">
                    <form action="<%=request.getContextPath()%>/users" method="post">

                        <input type="hidden" name="action" value="insert"/>

                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="text" name="phone" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select name="role" class="form-select" required>
                                <option value="admin">Admin</option>
                                <option value="user">User</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<%=request.getContextPath()%>/users" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-success">Add User</button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>