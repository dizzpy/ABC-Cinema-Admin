function confirmDelete(user_id) {
    if (confirm("Are you sure you want to delete this user?")) {
        fetch("DeleteUserServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `user_id=${user_id}`
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

function exportTableToCSV(filename) {
    const table = document.getElementById('userTable');
    const rows = table.querySelectorAll('tr');
    const csvContent = [];

    rows.forEach((row) => {
        const rowData = [];
        row.querySelectorAll('td, th').forEach((cell) => {
            let cellText = cell.textContent.trim();
            cellText = cellText.replace(/"/g, '""');
            rowData.push(`"${cellText}"`);
        });
        csvContent.push(rowData.join(','));
    });

    const blob = new Blob([csvContent.join('\n')], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    link.click();
}

function generatePDF() {
    // Clone the original table
    const table = document.getElementById("userTable").cloneNode(true);

    // Temporarily modify table colors for PDF
    table.querySelectorAll("th, td").forEach(cell => {
        cell.style.color = "#000"; // Black text
        cell.style.backgroundColor = "#f2f2f2"; // Light gray background
    });

    // Generate PDF with html2pdf
    const opt = {
        margin: 0.5,
        filename: "user-details.pdf",
        html2canvas: { scale: 2 },
        jsPDF: { unit: "in", format: "letter", orientation: "portrait" }
    };

    html2pdf().set(opt).from(table).save();
}