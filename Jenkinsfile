def VERSION_SNAPSHOT_REPO_NAME = "thfai2000/version_snapshots"
def VERSION_SNAPSHOT_FOLDER_NAME = "sample-app"
def GIT_BRANCH = env.BRANCH_NAME

pipeline {
    agent any

    parameters {
        choice(name: 'WHICH_ENV', choices: [1,2,3,4], description: 'Select the environment')
    }


    stages {
   

        stage('Access Files') {
            steps {
                script {
                    def workspacePath = pwd()
                    def files = findFiles(glob: '**/*', excludes: '')
                    
                    files.each { file ->
                        echo "File: ${file}"
                        // Perform operations on the file
                    }
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}




// pipeline {
//     agent any
    
//         // parameters {
//         //     choice(name: 'WHICH_ENV', choices: getFolderNames(), description: 'Select the environment')
//         //     choice(name: 'VERSION_SNAPSHOT', choices: getSnapshotVersions(), description: 'Select the snapshot version')
//         // }

//         stages {
//             stage('Input') {
//                 steps{
//                     node {
//                         def params = input(
//                             id: 'userInput', 
//                             message: 'Provide the build information',
//                             parameters [
//                                 string(defaultValue: 'None',
//                                                 description: 'Path of config file',
//                                                 name: 'Config')
//                                 // choice(name: 'WHICH_ENV', choices: getFolderNames(), description: 'Select the environment'),
//                                 // choice(name: 'VERSION_SNAPSHOT', choices: getSnapshotVersions(), description: 'Select the snapshot version')
//                                 // choice(name: 'WHICH_ENV', choices: [1,2], description: 'Select the environment'),
//                                 // choice(name: 'VERSION_SNAPSHOT', choices: [1,2], description: 'Select the snapshot version')
//                             ]
//                         )
//                     }
//                 }
//             }

//             stage('Loop through Artifacts') {
//                 steps {
//                     node {
//                         def artifacts = readYaml(url: getSnapshotUrl(params.VERSION_SNAPSHOT))

//                         for (def artifact in artifacts) {
//                             stage("Artifact: ${artifact.name}") {
//                                 def targetFolder = sh(script: 'dirname $0', returnStdout: true).trim() + "/${params.WHICH_ENV}"
//                                 def hostYamlFiles = findFiles(glob: "${targetFolder}/hosts/*.yaml")

//                                 for (def hostYamlFile in hostYamlFiles) {
//                                     def hostYaml = readYaml(file: hostYamlFile.path)
//                                     def hostComponents = hostYaml.host_components

//                                     for (def component in hostComponents) {
//                                         if (component.name == artifact.name) {
//                                             echo "Artifact '${artifact.name}' found in Host YAML: ${hostYamlFile.name}"
//                                         }
//                                     }
//                                 }
//                             }
//                         }
//                     }
                
//                 }
//             }
//         }
    
// }

def getFolderNames() {
    node {
        def currentDir = sh(script: 'pwd', returnStdout: true).trim()
        sh(script: "ls *")
        sh(script: "ls -d *")

        def folderList = sh(script: "ls -d * | xargs -n 1 basename", returnStdout: true).trim().split('\n')
        return folderList
    }
}

// def getSnapshotVersions() {
//     def gitSourceDirectory = '/path/to/git/source/directory' // Replace with your actual Git source directory
//     def treeApiUrl = "https://api.github.com/repos/$VERSION_SNAPSHOT_REPO_NAME/contents/$VERSION_SNAPSHOT_FOLDER_NAME?ref=$GIT_BRANCH"
    
//     def response = httpRequest(url: treeApiUrl, httpMode: 'GET', authentication: 'your_credentials')
//     def fileNames = []
//     if (response.status == 200) {
//         def json = readJSON(text: response.content)
//         fileNames = json.findAll { it.type == 'file' }.collect { it.name }
//     }
//     return fileNames
// }

// // def getSnapshotUrl(version) {
// //     def gitSourceDirectory = '/path/to/git/source/directory' // Replace with your actual Git source directory
// //     def snapshotUrl = "https://raw.githubusercontent.com/$VERSION_SNAPSHOT_REPO_NAME/$GIT_BRANCH/$VERSION_SNAPSHOT_FOLDER_NAME/$version"
// //     return snapshotUrl
// // }