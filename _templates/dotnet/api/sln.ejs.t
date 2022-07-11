---
to: <%= project %>/<%= project %>.sln
---
<%
  function uuidv4() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16).toUpperCase();
    });
  }
  SlnItemsGuid = uuidv4();
  SrcFolderGuid = uuidv4();
  TestsFolderGuid = uuidv4();
  MainProjectGuid = uuidv4();
  TestProjectGuid = uuidv4();
-%>
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio Version 17
VisualStudioVersion = 17.1.31911.260
MinimumVisualStudioVersion = 10.0.40219.1
Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") = "Solution Items", "Solution Items", "{<%= SlnItemsGuid %>}"
	ProjectSection(SolutionItems) = preProject
		.dockerignore = .dockerignore
		.editorconfig = .editorconfig
		.gitignore = .gitignore
		LICENSE = LICENSE
		README.md = README.md
	EndProjectSection
EndProject
Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") = "src", "src", "{<%= SrcFolderGuid %>}"
EndProject
Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") = "tests", "tests", "{<%= TestsFolderGuid %>}"
EndProject
Project("{FAE04EC0-301F-11D3-BF4B-00C04F79EFBC}") = "<%= project %>", "src\<%= project %>\<%= project %>.csproj", "{<%= MainProjectGuid %>}"
EndProject
Project("{FAE04EC0-301F-11D3-BF4B-00C04F79EFBC}") = "<%= project %>.Tests", "tests\<%= project %>.Tests\<%= project %>.Tests.csproj", "{<%= TestProjectGuid %>}"
EndProject
Global
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Any CPU = Debug|Any CPU
		Release|Any CPU = Release|Any CPU
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{<%= MainProjectGuid %>}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
		{<%= MainProjectGuid %>}.Debug|Any CPU.Build.0 = Debug|Any CPU
		{<%= MainProjectGuid %>}.Release|Any CPU.ActiveCfg = Release|Any CPU
		{<%= MainProjectGuid %>}.Release|Any CPU.Build.0 = Release|Any CPU
		{<%= TestProjectGuid %>}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
		{<%= TestProjectGuid %>}.Debug|Any CPU.Build.0 = Debug|Any CPU
		{<%= TestProjectGuid %>}.Release|Any CPU.ActiveCfg = Release|Any CPU
		{<%= TestProjectGuid %>}.Release|Any CPU.Build.0 = Release|Any CPU
	EndGlobalSection
	GlobalSection(SolutionProperties) = preSolution
		HideSolutionNode = FALSE
	EndGlobalSection
	GlobalSection(NestedProjects) = preSolution
		{<%= MainProjectGuid %>} = {<%= SrcFolderGuid %>}
		{<%= TestProjectGuid %>} = {<%= TestsFolderGuid %>}
	EndGlobalSection
	GlobalSection(ExtensibilityGlobals) = postSolution
		SolutionGuid = {87DA1E49-CD32-41E3-97C3-8FB20F2BA44A}
	EndGlobalSection
EndGlobal
