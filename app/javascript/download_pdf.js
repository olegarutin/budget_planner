$(document).on("click","#download-pdf",function() {
  alert("Do you want to download charts in pdf format?");
    var charts_pdf = document.getElementById('create-charts-pdf');
    var opt = {
      margin:       1,
      filename:     $("#report-from").data("date"),
      image:        { type: 'jpeg', quality: 0.98 },
      html2canvas:  { scale: 2 },
      jsPDF:        { unit: 'in', format: 'tabloid', orientation: 'landscape' }};
    html2pdf().set(opt).from(charts_pdf).save();
});
