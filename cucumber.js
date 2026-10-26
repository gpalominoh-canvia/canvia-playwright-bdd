export default {
  paths: ['features/**/*.feature'],
  import: ['src/**/*.ts'],
  format: ['progress-bar', 'html:reports/cucumber-report.html'],
  formatOptions: { snippetInterface: 'async-await' },
  language: 'es',
};
