$(document).ready(() => {

  const vapidPublicKey = new Uint8Array($('.body').data("webpush"));
  console.log('1dfdsfcsfadxas')
  if (navigator.serviceWorker) {
    console.log('2dfdsfcsfadxas')


  navigator.serviceWorker.register('/webpush.js')
  .then(function(reg) {
     console.log('Service worker change, registered the service worker');
  });


  navigator.serviceWorker.register('/webpush.js').then((reg) => {
    console.log('4dfdsfcsfadxas')
    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      console.log('3dfdsfcsfadxas')
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
     console.log('Service worker change, registered the service worker');
  });
  }
  else {
    console.error('Service worker is not supported in this browser');
  }

});

self.addEventListener("push", (event) => {
  console.log(event, 'ffsddfdfsd');
  let title = (event.data && event.data.text()) || "Yay a message";
  let body = "You've reached the limit of your wallet.";
  let tag = "push-simple-demo-notification-tag";
  let icon = '/assets/apple-touch-icon.png';
  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag })
  )
});
