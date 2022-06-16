self.addEventListener("push", (event) => {
  let title = (event.data && event.data.text()) || "Yay a message";
  let body = "Please, STOP =)";
  let tag = "push-simple-demo-notification-tag";
  let icon = '/assets/apple-touch-icon.png';

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag })
  )
});