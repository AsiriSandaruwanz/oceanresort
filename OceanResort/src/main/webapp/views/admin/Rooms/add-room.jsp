<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">Add New Room</h4>
                </div>

                <div class="card-body">

                    <form action="<%=request.getContextPath()%>/rooms"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden" name="action" value="insert"/>

                        <!-- ================= BASIC INFO ================= -->
                        <h5 class="mb-3 text-secondary">Basic Information</h5>

                        <div class="row g-3">

                            <div class="col-md-6">
                                <label class="form-label">Room Number</label>
                                <input type="text" name="roomNumber"
                                       class="form-control" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Title</label>
                                <input type="text" name="title"
                                       class="form-control" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Bed Type</label>
                                <input type="text" name="bedType"
                                       class="form-control">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Size</label>
                                <input type="text" name="size"
                                       class="form-control">
                            </div>

                        </div>

                        <!-- ================= PRICING ================= -->
                        <hr class="my-4">
                        <h5 class="mb-3 text-secondary">Pricing & Capacity</h5>

                        <div class="row g-3">

                            <div class="col-md-6">
                                <label class="form-label">Price Per Night</label>
                                <input type="number" step="0.01"
                                       name="pricePerNight"
                                       class="form-control">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Capacity</label>
                                <input type="number" name="capacity"
                                       class="form-control">
                            </div>

                        </div>

                        <!-- ================= AMENITIES ================= -->
                        <hr class="my-4">
                        <h5 class="mb-3 text-secondary">Amenities</h5>

                        <div class="mb-3">
                            <textarea name="amenities"
                                      class="form-control"
                                      rows="3"
                                      placeholder="WiFi, TV, AC, Balcony, etc."></textarea>
                        </div>

                        <!-- ================= IMAGE ================= -->
                        <hr class="my-4">
                        <h5 class="mb-3 text-secondary">Room Image</h5>

                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <input type="file"
                                       name="image"
                                       class="form-control"
                                       accept="image/*"
                                       onchange="previewImage(event)">
                            </div>

                            <div class="col-md-4 text-center">
                                <img id="preview"
                                     src=""
                                     class="img-fluid rounded border"
                                     style="max-height:150px; display:none;">
                            </div>
                        </div>

                        <!-- ================= BUTTONS ================= -->
                        <hr class="my-4">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<%=request.getContextPath()%>/rooms"
                               class="btn btn-outline-secondary">
                                Cancel
                            </a>

                            <button type="submit"
                                    class="btn btn-success">
                                Save Room
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<script>
function previewImage(event) {
    const image = document.getElementById('preview');
    image.src = URL.createObjectURL(event.target.files[0]);
    image.style.display = 'block';
}
</script>