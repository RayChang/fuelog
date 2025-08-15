module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Allow longer subject lines for more descriptive commits
    'subject-max-length': [2, 'always', 80],
    // Allow longer body lines
    'body-max-line-length': [2, 'always', 120],
    // Allow these scopes for the monorepo structure
    'scope-enum': [
      2,
      'always',
      ['web', 'crawler', 'ui', 'db', 'config', 'deps', 'docs', 'ci', 'release'],
    ],
    // Allow empty scope for general changes
    'scope-empty': [0, 'never'],
  },
};
