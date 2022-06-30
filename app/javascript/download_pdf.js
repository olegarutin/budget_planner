setTimeout(function (){
  $(document).on("click","#download-pdf",function() {
    let confirmAction = confirm("Do you want to download charts in pdf format?");
      if (confirmAction) {
        var charts_pdf = document.getElementById('create-charts-pdf');
        var opt = {
          margin: 1,
          filename: $("#report-from").data("date"),
          image: { type: 'jpeg', quality: 0.98 },
          html2canvas: { scale: 2,
                         width: 1500,
                         height: 900
                       },
          jsPDF: { unit: 'in', format: 'tabloid', orientation: 'landscape' }};
        html2pdf().set(opt).from(charts_pdf).save();
      }
      else {
        alert("Action canceled");
      }
  });
}, 2000);

$(document).on("click","#download-pdf-mobile",function() {
  let confirmAction = confirm("Do you want to download charts in pdf format?");
    if (confirmAction) {
      var charts_pdf = document.getElementById('create-charts-pdf');
      var opt = {
        margin: 0,
        filename: $("#report-from").data("date"),
        image: { type: 'jpeg', quality: 0.98 },
        html2canvas: { scale: 2,
                       windowWidth: 792
                     },
        jsPDF: { unit: 'in', format: 'letter', orientation: 'l' }};
      html2pdf().set(opt).from(charts_pdf).save();
    }
    else {
      alert("Action canceled");
    }
});

