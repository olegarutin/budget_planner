window.addEventListener("load", () => {
  const vapidPublicKey = new Uint8Array($('body').data("webpush"));
  console.log('fdgdfgvfd')
  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('/service_worker.js').then(function(registration) {
      console.log("registration", registration)
        registration.pushManager
        .subscribe({
          userVisibleOnly: true,
          applicationServerKey: vapidPublicKey
        }).then(async function(PushSubscription) {
          console.log('2fdgdfgvfd')
          const data = await fetch('/webpush_subscriptions', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(PushSubscription),
          }).then(r => r.json());
          console.log(data);
        });
       console.log('Service worker change, registered the service worker');
      });
    }
  else {
    console.error('Service worker is not supported in this browser');
  }
});
