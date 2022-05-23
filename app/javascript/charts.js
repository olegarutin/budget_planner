var Bar = function() {

  Chart1 = require('chart.js')

  ctx1 = document.getElementById('chart-bar');
  var chartBar = new Chart1(ctx1, {
    type: 'bar',
    data: {
      labels: $('#chart-bar').data("labels"),
      datasets: [{
        label: 'Amount for categories',
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
          'rgb(255, 205, 86)'
        ],
        hoverOffset: 4
      }]
    }
  });
}

var StackedBar = function() {

  Chart3 = require('chart.js')

  ctx3 = document.getElementById('chart-stacked');
  chartStacked = new Chart3(ctx3, {
    type: 'line',
    data: {
      labels: $('#chart-stacked').data("labels"),
      datasets: [{
        label: 'Expense',
        data1: $('#chart-stacked').data("data1"),
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        borderColor: 'rgb(255, 99, 132)',
        stack: 'combined',
        type: 'bar'
      }, {
        label: 'Income',
        data2: $('#chart-stacked').data("data2"),
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgb(54, 162, 235)',
        stack: 'combined'
      }]
    },
    scales: {
      y: {
        stacked: true
      }
    }
  });
}

var Line = function() {

  Chart4 = require('chart.js')

  ctx4 = document.getElementById('chart-line');
  chartLine = new Chart4(ctx4, {
    type: 'line',
    data: {
      labels: $('#chart-line').data("labels"),
      datasets: [{
          label: 'SMTH',
          data: $('#chart-line').data("data"),
          borderColor: 'rgb(75, 192, 192)',
          tension: 0.1
        }]
    }
  });
}


document.addEventListener("turbo:load", () => {
  Bar();
  Pie();
  StackedBar();
  Line();
});
