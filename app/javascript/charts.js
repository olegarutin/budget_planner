Chart = require('chart.js');

var Bar = function() {
  let chartBar = document.getElementById('chart-bar');

  if (chartBar) {
    new Chart(chartBar, {
      type: 'bar',
      data: {
        labels: $('#chart-bar').data('labels'),
        datasets: [{
          label: 'Show/Hide Charts',
          data: $('#chart-bar').data('data'),
          backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)',
            'rgba(117, 23, 15, 0.2)',
            'rgba(200, 100, 115, 0.2)',
            'rgba(64, 138, 12, 0.2)',
            'rgba(201, 80, 55, 0.2)',
            'rgba(135, 40, 27, 0.2)'
          ],
          borderColor: [
            'rgba(255, 99, 132, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)',
            'rgba(255, 159, 64, 1)',
            'rgba(117, 23, 15, 1)',
            'rgba(200, 100, 115, 1)',
            'rgba(64, 138, 12, 1)',
            'rgba(201, 80, 55, 1)',
            'rgba(135, 40, 27, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          y: { beginAtZero: true }
        }
      }
    });
  }
};

var Pie = function() {
  let chartPie = document.getElementById('chart-pie');

  if (chartPie) {
    new Chart(chartPie, {
      type: 'pie',
      data: {
        labels: $('#chart-pie').data('labels'),
        datasets: [{
          label: 'Pie Chart',
          data: $('#chart-pie').data('data'),
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(54, 162, 235)',
            'rgb(255, 205, 86)',
            'rgb(255, 205, 86)',
            'rgb(248, 18, 22)',
            'rgb(45, 156, 20)',
            'rgb(120, 30, 48)',
            'rgb(120, 30, 48)',
            'rgb(100, 130, 20)',
            'rgb(18, 90, 125)',
            'rgb(60, 15, 200)'
          ],
          hoverOffset: 4
        }]
      }
    });
  }
};

document.addEventListener('turbo:load', () => {
  Bar();
  Pie();
});
