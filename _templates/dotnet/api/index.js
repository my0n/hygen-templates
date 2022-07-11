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
        { name: 'Dependabot', value: "Dependabot", hint: "Adds a dependabot config" },
        { name: 'GitHub Actions', value: "GitHub Actions", hint: "Adds a GitHub Actions build pipeline for the project" }
      ]
    });

    if (results.ci.includes('GitHub Actions')) {
      await apply({
        type: 'multiselect',
        name: 'ghaArtifactRepos',
        message: 'Select where to push build results from the GitHub actions pipeline',
        hint: 'Use <space> to select, <return> to submit',
        choices: [
          { name: 'GitHub', value: "GitHub", hint: "Push docker images to ghcr.io" }
        ]
      });

      await apply({
        type: 'input',
        name: 'ghaAppDockerName',
        message: 'Enter the name of the published app docker image'
      });

      if (results.features.includes('Entity Framework')) {
        await apply({
          type: 'input',
          name: 'ghaMigrationsDockerName',
          message: 'Enter the name of the published Entity Framework migrations docker image'
        });
      } else {
        results['ghaMigrationsDockerName'] = "";
      }
    } else {
      results['ghaArtifacts'] = [];
      results['ghaAppDockerName'] = "";
      results['ghaMigrationsDockerName'] = "";
    }

    return results;
  }
};
