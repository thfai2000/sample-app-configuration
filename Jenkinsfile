pipeline {
    agent any

    parameters {
        string(name: 'WHICH_ENV', description: 'Enter the environment name')
        string(name: 'VERSION_SNAPSHOT', description: 'Enter the snapshot version URL')
    }

    stages {
        stage('Loop through Artifacts') {
            steps {
                script {
                    def artifacts = readYaml(url: params.VERSION_SNAPSHOT)

                    for (def artifact in artifacts) {
                        stage("Artifact: ${artifact.name}") {
                            def targetFolder = sh(script: 'dirname $0', returnStdout: true).trim() + "/${params.WHICH_ENV}"
                            def hostYamlFiles = findFiles(glob: "${targetFolder}/*.yaml")

                            for (def hostYamlFile in hostYamlFiles) {
                                def hostYaml = readYaml(file: hostYamlFile.path)
                                def hostComponents = hostYaml.host_components

                                for (def component in hostComponents) {
                                    if (component.name == artifact.name) {
                                        echo "Artifact '${artifact.name}' found in Host YAML: ${hostYamlFile.name}"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}