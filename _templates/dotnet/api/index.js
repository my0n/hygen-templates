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
      message: "Enter the author name"
    });

    await apply({
      type: 'input',
      name: 'project',
      message: "Enter the project name"
    });

    await apply({
      type: 'multiselect',
      name: 'features',
      message: 'Select which features to include',
      hint: 'Use <space> to select, <return> to submit',
      choices: [
        { name: 'API/Controllers', value: "API/Controllers", hint: "Adds the WeatherForecastController and Swashbuckle" },
        { name: 'API/Entity Framework', value: "API/Entity Framework", hint: "Adds Entity Framework with some example code-first entity definitions" },
        { name: 'API/File provider', value: "API/File provider", hint: "Adds a file provider" },
        { name: 'API/Health checks', value: "API/Health checks", hint: "Adds health checks, including support for other enabled features" },
        { name: 'CI/Dependabot', value: "CI/Dependabot", hint: "Adds a dependabot config" },
        { name: 'CI/GitHub Actions', value: "CI/GitHub Actions", hint: "Adds a GitHub Actions build pipeline for the project" },
        { name: 'CI/ghcr.io', value: "CI/ghcr.io", hint: "Push docker images to ghcr.io" }
      ]
    });

    if (results.features.includes('CI/ghcr.io')) {
      await apply({
        type: 'input',
        name: 'dockerImageName',
        message: 'Enter the name of the published docker image'
      });
    } else {
      results['dockerImageName'] = "";
    }

    return results;
  }
};
