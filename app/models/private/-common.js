import Model, { attr } from '@ember-data/model';

export default class CommonModel extends Model {
  @attr version;
  @attr changes;

  get features() {
    return (this.changes || []).filter((change) => Boolean(change?.feature));
  }

  get deprecations() {
    return (this.changes || []).filter((change) =>
      Boolean(change?.deprecation),
    );
  }
}
