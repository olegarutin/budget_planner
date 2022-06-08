var Pie = function() {

  Chart2 = require('chart.js')

  ctx2 = document.getElementById('chart-pie');
  chartPie = new Chart2(ctx2, {
    type: 'pie',
    data: {
      labels: $('#chart-pie').data("labels"),
      datasets: [{
        label: 'My First Dataset',
        data: $('#chart-pie').data("data"),
        backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)',
          'rgb(255, 205, 86)'
        ],
        hoverOffset: 4
      }]
    }
  });
}

document.addEventListener("turbo:load", () => {
  Pie();
});
