let prompts = [
  {
    type: "input",
    name: "project_name",
    message: "Enter the project name:",
    default: "tf-basic"
  },
  {
    type: "input",
    name: "domain",
    message: "Enter your domain name:",
    default: "helo-k8s.fun"
  },
  {
    type: "list",
    name: "cloudProvider",
    message: "Select cloud provider:",
    choices: ["aws", "azure", "gcp", "minikube"]
  },
  {
    when: props => props.cloudProvider === "aws",
    type: "input",
    name: "awsRegion",
    message: "Enter region:"
  },
  {
    when: props => props.cloudProvider === "aws",
    type: "input",
    name: "awsAccessKey",
    message: "Enter aws access key:"
  },
  {
    when: props => props.cloudProvider === "aws",
    type: "input",
    name: "awsSecretKey",
    message: "Enter aws secret key:"
  },
  {
    when: props => props.cloudProvider === "gcp",
    type: "input",
    name: "gcpProject",
    message: "Enter project:"
  },
  {
    when: props => props.cloudProvider === "gcp",
    type: "input",
    name: "gcpRegion",
    message: "Enter region:"
  },
  {
    when: props => props.cloudProvider === "gcp",
    type: "input",
    name: "gcpZone",
    message: "Enter zone:"
  },
  {
    type: "list",
    name: "orchestration",
    message: "Select orchestration provider:",
    choices: ["kubernetes", "docker swarm"]
  },
  {
    type: "input",
    name: "namespace",
    message: "Enter namespace",
    default: "wdi"
  },
  {
    type: "input",
    name: "clusterName",
    message: "Enter cluster name",
    default: "TIC_Demo_Cluster"
  },
  {
    type: "list",
    name: "ingress",
    message: "Select Ingress Type",
    choices: ["Nginx", "ISTIO"]
  },
  // {
  //   type: "list",
  //   name: "frontend",
  //   message: "Select frontend framework:",
  //   choices: ["Angular", "ReactJS", "Vue.js"]
  // },
  // {
  //   when: props => props.frontend === "ReactJS",
  //   type: "confirm",
  //   name: "react",
  //   message: "confirm do you want to use React",
  //   default: true
  // },
  // {
  //   when: props => props.frontend === "ReactJS",
  //   type: "input",
  //   name: "reactImage",
  //   message: "Enter React docker image",
  //   default: "raxkumar/k8s-terraform-react-keycloak:latest"
  // },
  // {
  //   when: props => props.frontend === "ReactJS",
  //   type: "input",
  //   name: "reactPort",
  //   message: "Enter React port",
  //   default: "3000"
  // },
  // {
  //   when: props => props.frontend === "Angular",
  //   type: "confirm",
  //   name: "angular",
  //   message: "confirm do you want to use Angular",
  //   default: true
  // },
  // {
  //   when: props => props.frontend === "Vue.js",
  //   type: "confirm",
  //   name: "vuejs",
  //   message: "confirm do you want to use Vue.js",
  //   default: true
  // },
  // {
  //   type: "list",
  //   name: "oauth",
  //   message: "Select OAuth provider:",
  //   choices: ["a12n-server", "Keycloak"]
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "confirm",
  //   name: "keycloak",
  //   message: "confirm do you want to use Keycloak",
  //   default: true
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakEmail",
  //   message: "Enter Keycloak Email",
  //   default: "admin@admin.com"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakFirstName",
  //   message: "Enter Keycloak user first name",
  //   default: "admin"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakLastName",
  //   message: "Enter Keycloak user last name",
  //   default: "admin"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakClientId",
  //   message: "Enter Keycloak name",
  //   default: "admin-cli"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakAdminUser",
  //   message: "Enter keycloak admin username",
  //   default: "admin"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakAdminPassword",
  //   message: "Enter keycloak admin password",
  //   default: "admin"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakRealmName",
  //   message: "Enter keycloak Realm Name",
  //   default: "Mavas"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakPublicClient",
  //   message: "Enter public client name",
  //   default: "mavas-web"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakDefaultUser",
  //   message: "Enter keycloak Default User",
  //   default: "user"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakDefaultUserPassword",
  //   message: "Enter keycloak Default User Password",
  //   default: "password"
  // },
  // {
  //   when: props => props.oauth === "Keycloak",
  //   type: "input",
  //   name: "keycloakDBPassword",
  //   message: "Enter keycloak DB Password",
  //   default: "keycloak"
  // },
  // {
  //   when: props => props.oauth === "a12n-server",
  //   type: "confirm",
  //   name: "a12nServer",
  //   message: "confirm do you want to use a12n-server",
  //   default: true
  // },
  // {
  //   type: "list",
  //   name: "backend",
  //   message: "Select Backend:",
  //   choices: ["nodejs", "spring", "flask", "golang"]
  // },
  // {
  //   when: props => props.backend === "nodejs",
  //   type: "confirm",
  //   name: "nodejs",
  //   message: "confirm do you want to use nodejs",
  //   default: true
  // },
  // {
  //   when: props => props.backend === "spring",
  //   type: "confirm",
  //   name: "spring",
  //   message: "confirm do you want to use spring",
  //   default: true
  // },
  // {
  //   when: props => props.backend === "spring",
  //   type: "input",
  //   name: "springPort",
  //   message: "Enter the port of your spring application",
  //   default: "8080"
  // },
  // {
  //   when: props => props.backend === "flask",
  //   type: "confirm",
  //   name: "flask",
  //   message: "confirm do you want to use flask",
  //   default: true
  // },
  // {
  //   when: props => props.backend === "golang",
  //   type: "confirm",
  //   name: "golang",
  //   message: "confirm do you want to use golang",
  //   default: true
  // },
  // {
  //   type: "list",
  //   name: "database",
  //   message: "Select Database:",
  //   choices: ["MySQL", "PostgreSQL", "MongoDB", "Redis", "Cassandra", "Neo4j"]
  // },
  // {
  //   when: props => props.database === "MySQL",
  //   type: "confirm",
  //   name: "mysql",
  //   message: "confirm do you want to use MySQL",
  //   default: true
  // },
  // {
  //   when: props => props.database === "MySQL",
  //   type: "input",
  //   name: "mysqlServer",
  //   message: "Enter MySQL server",
  //   default: "demo-app-mysql"
  // },
  // {
  //   when: props => props.database === "MySQL",
  //   type: "input",
  //   name: "mysqlUserName",
  //   message: "Enter MySQL User Name",
  //   default: "myUser"
  // },
  // {
  //   when: props => props.database === "MySQL",
  //   type: "input",
  //   name: "mysqlDBName",
  //   message: "Enter MySQL DB name",
  //   default: "myUser"
  // },
  // {
  //   when: props => props.database === "PostgreSQL",
  //   type: "confirm",
  //   name: "postgreSql",
  //   message: "confirm do you want to use PostgreSQL",
  //   default: true
  // },
  // {
  //   when: props => props.database === "PostgreSQL",
  //   type: "input",
  //   name: "postgrePassword",
  //   message: "Enter postgre password",
  //   default: "root"
  // },
  // {
  //   when: props => props.database === "PostgreSQL",
  //   type: "input",
  //   name: "postgreUserName",
  //   message: "Enter postgre user name",
  //   default: "root"
  // },
  // {
  //   when: props => props.database === "PostgreSQL",
  //   type: "input",
  //   name: "postgreServerName",
  //   message: "Enter postgre server name",
  //   default: "postgres-db"
  // },
  // {
  //   when: props => props.database === "PostgreSQL",
  //   type: "input",
  //   name: "postgreDatabaseName",
  //   message: "Enter postgre database name",
  //   default: "test"
  // },
  // {
  //   when: props => props.database === "MongoDB",
  //   type: "confirm",
  //   name: "mongoDB",
  //   message: "confirm do you want to use MongoDB",
  //   default: true
  // },
  // {
  //   when: props => props.database === "Redis",
  //   type: "confirm",
  //   name: "redis",
  //   message: "confirm do you want to use Redis",
  //   default: true
  // },
  // {
  //   when: props => props.database === "Cassandra",
  //   type: "confirm",
  //   name: "cassandra",
  //   message: "confirm do you want to use Cassandra",
  //   default: true
  // },
  // {
  //   when: props => props.database === "Neo4j",
  //   type: "confirm",
  //   name: "neo4j",
  //   message: "confirm do you want to use Neo4j",
  //   default: true
  // }
];

module.exports = prompts;
