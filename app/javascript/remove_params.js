$(document).on("click","#remove-params",function() {
  if (typeof URLSearchParams !== 'undefined') {
    const params = new URLSearchParams()
    
    console.log(params.toString())
    
    params.delete()
    
    console.log(params.toString())
  }
  else {
    console.log(`Your browser ${navigator.appVersion} does not support URLSearchParams`)
  }
});
