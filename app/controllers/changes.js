import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { VERSIONS } from 'upgrade-guide/utils/ember-versions';

export default class ChangesController extends Controller {
  @service router;
  queryParams = ['fromVersion', 'toVersion'];

  @tracked fromVersion = '3.15';
  @tracked toVersion = VERSIONS[VERSIONS.length - 1];

  @action displayChanges({ fromVersion, toVersion }) {
    this.router.transitionTo('changes', {
      queryParams: {
        fromVersion,
        toVersion,
      },
    });
  }
}
