import Component from '@glimmer/component';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import {
  VERSIONS,
  GROUPED_VERSIONS,
  isLegalVersion,
  DEFAULT_FROM_VERSION,
  DEFAULT_TO_VERSION,
  areVersionsValid,
} from 'upgrade-guide/utils/ember-versions';
import { compare } from 'compare-versions';
import { on } from '@ember/modifier';
import { concat } from '@ember/helper';
import eq from 'ember-truth-helpers/helpers/equal';
import '../styles/ember-versions-form.css';

const isFromVersionInvalid = (version, toVersion) => {
  return (
    isLegalVersion(version) &&
    isLegalVersion(toVersion) &&
    compare(version, toVersion, '>=')
  );
};

const isToVersionInvalid = (version, fromVersion) => {
  return (
    isLegalVersion(version) &&
    isLegalVersion(fromVersion) &&
    compare(version, fromVersion, '<=')
  );
};

export default class EmberVersionsFormComponent extends Component {
  versions = VERSIONS;
  groupedVersions = GROUPED_VERSIONS;
  @tracked fromVersion = isLegalVersion(this.args.from)
    ? this.args.from
    : DEFAULT_FROM_VERSION;
  @tracked toVersion = isLegalVersion(this.args.to)
    ? this.args.to
    : DEFAULT_TO_VERSION;

  @action submitForm(event) {
    event.preventDefault();

    const { onSubmit } = this.args;

    if (onSubmit) {
      onSubmit({
        fromVersion: this.fromVersion,
        toVersion: this.toVersion,
      });
    }
  }

  @action updateFromVersion(event) {
    this.fromVersion = event.target.value;
    if (this.args.submitOnChange) {
      this.#submitForm(this.fromVersion, this.toVersion);
    }
  }

  @action updateToVersion(event) {
    this.toVersion = event.target.value;
    if (this.args.submitOnChange) {
      this.#submitForm(this.fromVersion, this.toVersion);
    }
  }

  // NOTE: We do not validate valid combinations here. The UI discourages invalid combinations,
  // but does not prevent them.
  #submitForm = (from, to) => {
    if (this.args.onSubmit) {
      this.args.onSubmit({
        fromVersion: from,
        toVersion: to,
      });
    }
  };

  <template>
    <form
      class="ember-versions-form"
      data-test-form="Ember Versions"
      {{on "submit" this.submitForm}}
    >
      <div class="mb-3 form-inputs">
        <span>Upgrading</span>
        <label for="from-version">from version</label>

        <select
          data-test-select="From Version"
          id="from-version"
          {{on "input" this.updateFromVersion}}
        >
          {{#each this.groupedVersions as |versionGroup|}}
            <optgroup label={{concat "v" versionGroup.major ".x"}}>
              <legend>{{versionGroup.major}}.x Versions</legend>
              {{#each versionGroup.versions as |version|}}
                <option
                  selected={{eq version this.fromVersion}}
                  value={{version}}
                  class={{if
                    (isFromVersionInvalid version this.toVersion)
                    "is-invalid"
                  }}
                >
                  {{version}}
                </option>
              {{/each}}
            </optgroup>
          {{/each}}
        </select>

        <label for="to-version">to version</label>

        <select
          data-test-select="To Version"
          id="to-version"
          {{on "input" this.updateToVersion}}
        >
          {{#each this.groupedVersions as |versionGroup|}}
            <optgroup label={{concat "v" versionGroup.major ".x"}}>
              <legend>{{versionGroup.major}}.x Versions</legend>
              {{#each versionGroup.versions as |version|}}
                <option
                  selected={{eq version this.toVersion}}
                  value={{version}}
                  class={{if
                    (isToVersionInvalid version this.fromVersion)
                    "is-invalid"
                  }}
                >
                  {{version}}
                </option>
              {{/each}}
            </optgroup>
          {{/each}}
        </select>
      </div>

      {{#unless @hideFindButton}}
        <button
          class="es-button mt-2"
          data-test-button="Find Changes"
          type="submit"
          disabled={{unless
            (areVersionsValid this.fromVersion this.toVersion)
            true
          }}
        >
          Find Changes
        </button>
      {{/unless}}

    </form>
    {{#unless (areVersionsValid this.fromVersion this.toVersion)}}
      <div role="alert" class="well mt-2 p-2">
        To version should be higher than From version
      </div>
    {{/unless}}
  </template>
}
