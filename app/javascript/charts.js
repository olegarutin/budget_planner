var Bar = function() {

  Chart1 = require('chart.js')

  ctx1 = document.getElementById('chart-bar');
  var chartBar = new Chart1(ctx1, {
    type: 'bar',
    data: {
      labels: $('#chart-bar').data("labels"),
      datasets: [{
        label: 'Show/Hide Charts',,
        data: $('#chart-bar').data("data"),
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
          y: {
              beginAtZero: true
          }
      }
    }
  });
}

var Pie = function() {

  Chart2 = require('chart.js')

  ctx2 = document.getElementById('chart-pie');
  chartPie = new Chart2(ctx2, {
    type: 'pie',
    data: {
      labels: $('#chart-pie').data("labels"),
      datasets: [{
        label: 'Pie Chart',
        data: $('#chart-pie').data("data"),
        backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)',
          'rgb(255, 205, 86)',
          'rgb(255, 205, 86)',
          'rgb(248, 18, 22)',
          'rgb(45, 156, 20)',
          'rgb(120, 30, 48)'
        ],
        hoverOffset: 4
      }]
    }
  });
}

document.addEventListener("turbo:load", () => {
  Bar();
  Pie();
});
