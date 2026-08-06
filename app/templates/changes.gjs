import CliUpdateCommands from 'upgrade-guide/components/cli-update-commands';
import ListFeaturesDeprecations from 'upgrade-guide/components/list-features-deprecations';
import { LinkTo } from '@ember/routing';
import EmberVersionsForm from 'upgrade-guide/components/ember-versions-form';
import { areVersionsValid } from 'upgrade-guide/utils/ember-versions';

<template>
  <section class="container">

    <EmberVersionsForm
      @onSubmit={{@controller.displayChanges}}
      @from={{@controller.fromVersion}}
      @to={{@controller.toVersion}}
      @submitOnChange={{true}}
      @hideFindButton={{true}}
    />

    {{#if (areVersionsValid @controller.fromVersion @controller.toVersion)}}

      <CliUpdateCommands
        @fromVersion={{@controller.fromVersion}}
        @toVersion={{@controller.toVersion}}
      />

      <div data-test-package="Ember.js">
        <h2>Ember.js</h2>
        <ListFeaturesDeprecations
          @allChangeLogs={{@model.emberJSChanges}}
          @fromVersion={{@controller.fromVersion}}
          @toVersion={{@controller.toVersion}}
        />
      </div>

      <div data-test-package="Ember Data">
        <h2>Ember Data</h2>
        <ListFeaturesDeprecations
          @allChangeLogs={{@model.emberDataChanges}}
          @fromVersion={{@controller.fromVersion}}
          @toVersion={{@controller.toVersion}}
        />
      </div>

      <div data-test-package="Ember CLI">
        <h2>Ember CLI</h2>
        <ListFeaturesDeprecations
          @allChangeLogs={{@model.emberCLIChanges}}
          @fromVersion={{@controller.fromVersion}}
          @toVersion={{@controller.toVersion}}
        />
      </div>

    {{else}}
      <div class="min-h-50vh"></div>
    {{/if}}

    <h2>Contribute</h2>
    Improve the upgrade guide and open issues over at the
    <a
      href="https://github.com/ember-learn/upgrade-guide#upgrade-guide"
      rel="external"
    >
      repo
    </a>
    <p></p>
    <p></p>
    <LinkTo data-test-link="Choose different versions" @route="index">
      Choose different versions
    </LinkTo>
  </section>
</template>
