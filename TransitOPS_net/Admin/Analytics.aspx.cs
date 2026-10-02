using System;
using System.Text;

namespace TransitOPS_net.Admin
{
    public partial class Analytics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            // 1. KPI Data
            litTotalFleet.Text = "42";
            litActiveTrips.Text = "18";
            litUtilization.Text = "76.5";
            litDrivers.Text = "24";

            // 2. Generate Chart Data Scripts
            StringBuilder script = new StringBuilder();
            script.AppendLine("<script>");
            script.AppendLine("document.addEventListener('DOMContentLoaded', function() {");

            // Trend Chart
            script.AppendLine(@"
                const trendCtx = document.getElementById('trendChart').getContext('2d');
                new Chart(trendCtx, {
                    type: 'line',
                    data: {
                        labels: ['Sep 19','Sep 20','Sep 21','Sep 22','Sep 23','Sep 24','Sep 25','Sep 26','Sep 27','Sep 28','Sep 29','Sep 30','Oct 1','Oct 2'],
                        datasets: [{
                            label: 'Trips',
                            data: [12, 19, 15, 17, 14, 22, 24, 21, 18, 25, 28, 26, 30, 27],
                            borderColor: '#1b4332',
                            backgroundColor: 'rgba(27,67,50,0.1)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.4
                        }]
                    },
                    options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { borderDash: [3, 3] } }, x: { grid: { display: false } } } }
                });
            ");

            // Type Chart
            script.AppendLine(@"
                const typeCtx = document.getElementById('typeChart').getContext('2d');
                new Chart(typeCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Cargo Van', 'Heavy Duty', 'Specialized', 'Light Duty'],
                        datasets: [{
                            label: 'Vehicles',
                            data: [18, 12, 5, 7],
                            backgroundColor: ['#1b4332', '#2d6a4f', '#40916c', '#52b788'],
                            borderRadius: 6
                        }]
                    },
                    options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { borderDash: [3, 3] } }, x: { grid: { display: false } } } }
                });
            ");

            // Status Chart
            script.AppendLine(@"
                const statusCtx = document.getElementById('statusChart').getContext('2d');
                new Chart(statusCtx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Active', 'Maintenance', 'Inactive'],
                        datasets: [{
                            data: [32, 6, 4],
                            backgroundColor: ['#10b981', '#f59e0b', '#ef4444'],
                            borderWidth: 0
                        }]
                    },
                    options: { responsive: true, maintainAspectRatio: false, cutout: '65%', plugins: { legend: { position: 'right' } } }
                });
            ");

            script.AppendLine("});");
            script.AppendLine("</script>");

            litChartData.Text = script.ToString();
        }
    }
}
