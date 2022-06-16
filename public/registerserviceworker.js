const vapidPublicKey = new Uint8Array(<%= Base64.urlsafe_decode64(ENV['WEBPUSH_PUBLIC_KEY']).bytes %>);

if (navigator.serviceWorker) {
navigator.serviceWorker.register('/serviceworker.js')
.then(function(reg) {
   // application.js
  // When serviceWorker is supported, installed, and activated,
  // subscribe the pushManager property with the vapidPublicKey
  navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
    serviceWorkerRegistration.pushManager
    .subscribe({
      userVisibleOnly: true,
      applicationServerKey: vapidPublicKey
    }).then(async function(PushSubscription) {
      const data = await fetch('/dashboard', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(PushSubscription),
      }).then(r => r.json());
      console.log(data);
    });
  });
   // console.log('Service worker change, registered the service worker');
});
}
// Otherwise, no push notifications :(
else {
  console.error('Service worker is not supported in this browser');
}
