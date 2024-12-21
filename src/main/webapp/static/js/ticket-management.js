function confirmDeleteTicket(order_id) {
    if (confirm("Are you sure you want to delete this user?")) {
        fetch("DeleteTicketServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `order_id=${order_id}`
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
