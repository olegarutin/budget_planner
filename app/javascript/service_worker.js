document.addEventListener("turbo:load", () => {

  const vapidPublicKey = new Uint8Array($('.body').data("webpush"));

  if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service_worker.js', { scope: './' })
  .then(function(reg) {
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
  else {
    console.error('Service worker is not supported in this browser');
  }

});

document.addEventListener("push", (event) => {
  let title = (event.data && event.data.text()) || "Yay a message";
  let body = "You've reached the limit of your wallet.";
  let tag = "push-simple-demo-notification-tag";
  let icon = '/assets/apple-touch-icon.png';

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag })
  )
});
