def VERSION_SNAPSHOT_REPO_NAME = "thfai2000/version_snapshots"
def VERSION_SNAPSHOT_FOLDER_NAME = "sample-app"
def GIT_BRANCH = env.BRANCH_NAME

pipeline {
    agent any

    stages {
        stage('Input') {
            steps {
                def params = input(
                    message: 'Provide the build information',
                    // parameters [
                    //     choice(name: 'WHICH_ENV', choices: getFolderNames(), description: 'Select the environment')
                    //     choice(name: 'VERSION_SNAPSHOT', choices: getSnapshotVersions(), description: 'Select the snapshot version')
                    // ]
                )
            }
        }

        stage('Loop through Artifacts') {
            steps {
                script {
                    def artifacts = readYaml(url: getSnapshotUrl(params.VERSION_SNAPSHOT))

                    for (def artifact in artifacts) {
                        stage("Artifact: ${artifact.name}") {
                            def targetFolder = sh(script: 'dirname $0', returnStdout: true).trim() + "/${params.WHICH_ENV}"
                            def hostYamlFiles = findFiles(glob: "${targetFolder}/hosts/*.yaml")

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

def getFolderNames() {
    def currentDir = sh(script: 'dirname $0', returnStdout: true).trim()
    def folderList = sh(script: "ls -d ${currentDir}/*/ | awk -F/ '{print \$NF}'", returnStdout: true).trim().split('\n')
    return folderList
}

def getSnapshotVersions() {
    def gitSourceDirectory = '/path/to/git/source/directory' // Replace with your actual Git source directory
    def treeApiUrl = "https://api.github.com/repos/$VERSION_SNAPSHOT_REPO_NAME/contents/$VERSION_SNAPSHOT_FOLDER_NAME?ref=$GIT_BRANCH"
    
    def response = httpRequest(url: treeApiUrl, httpMode: 'GET', authentication: 'your_credentials')
    def fileNames = []
    if (response.status == 200) {
        def json = readJSON(text: response.content)
        fileNames = json.findAll { it.type == 'file' }.collect { it.name }
    }
    return fileNames
}

def getSnapshotUrl(version) {
    def gitSourceDirectory = '/path/to/git/source/directory' // Replace with your actual Git source directory
    def snapshotUrl = "https://raw.githubusercontent.com/$VERSION_SNAPSHOT_REPO_NAME/$GIT_BRANCH/$VERSION_SNAPSHOT_FOLDER_NAME/$version"
    return snapshotUrl
}