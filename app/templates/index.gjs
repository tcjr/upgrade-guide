import EmberVersionsForm from 'upgrade-guide/components/ember-versions-form';
<template>
  <section class="container min-h-50vh">

    <EmberVersionsForm @onSubmit={{@controller.displayChanges}} />

  </section>
</template>
