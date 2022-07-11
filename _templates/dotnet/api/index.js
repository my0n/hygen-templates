const getApplier = (prompter, args, results) => {
  return async (options) => {
    const value = await prompter.prompt(options);
    Object.assign(results, value);
  };
};

module.exports = {
  prompt: async ({ prompter, args }) => {
    const results = {
      usesControllers: true,
      usesEF: false,
      usesFileProvider: false,
      usesHealthChecks: true
    };
    const apply = getApplier(prompter, args, results);

    await apply({
      type: 'input',
      name: 'author',
      message: "Author?"
    });

    await apply({
      type: 'input',
      name: 'project',
      message: "Project name?"
    });

    await apply({
      type: 'confirm',
      name: 'usesControllers',
      message: "Use controllers?"
    });

    await apply({
      type: 'confirm',
      name: 'usesEF',
      message: "Use Entity Framework?"
    });

    await apply({
      type: 'confirm',
      name: 'usesFileProvider',
      message: "Create an example file provider?"
    });

    await apply({
      type: 'confirm',
      name: 'usesHealthChecks',
      message: "Use health checks?"
    });

    return results;
  }
};
