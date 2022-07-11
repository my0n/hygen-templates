const getApplier = (prompter, args, results) => {
  return async (options) => {
    const value = await prompter.prompt(options);
    Object.assign(results, value);
  };
};

module.exports = {
  prompt: async ({ prompter, args }) => {
    const results = {};
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
      type: 'multiselect',
      name: 'features',
      message: 'Select which features to include',
      hint: 'Use <space> to select, <return> to submit',
      choices: [
        { name: 'Controllers', value: "Controllers", hint: "Adds the WeatherForecastController and Swashbuckle" },
        { name: 'Entity Framework', value: "Entity Framework", hint: "Adds Entity Framework with some example code-first entity definitions" },
        { name: 'File provider', value: "File provider", hint: "Adds a file provider" },
        { name: 'Health checks', value: "Health checks", hint: "Adds health checks, including support for other enabled features" }
      ]
    });

    await apply({
      type: 'multiselect',
      name: 'ci',
      message: 'Select which CI options to enable',
      hint: 'Use <space> to select, <return> to submit',
      choices: [
        { name: 'GitHub Actions', value: "GitHub Actions", hint: "Adds a build pipeline for the project" }
      ]
    });

    return results;
  }
};
