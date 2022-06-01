import { application } from './application';
import controllers from './**/*_controller.js';
import PasswordVisibility from 'stimulus-password-visibility';

application.register('password-visibility', PasswordVisibility);

controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default);
});
