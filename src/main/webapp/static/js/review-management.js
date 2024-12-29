function confirmDeleteReview(review_id) {
    if (confirm("Are you sure you want to delete this user?")) {
        fetch("DeleteReviewServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `review_id=${review_id}`
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to delete user");
                }
                return response.text(); // Or JSON if the response sends back data
            })
            .then(() => {
                alert("User deleted successfully");
                location.reload();
            })

    }
}
