import RouteTemplate from 'ember-route-template';
import EmberVersionsForm from 'upgrade-guide/components/ember-versions-form';
export default RouteTemplate(
  <template>
    <section class="container">
      <h1 class="es-heading">Upgrade Guide</h1>

      <EmberVersionsForm @onSubmit={{@controller.displayChanges}} />
    </section>
  </template>,
);
