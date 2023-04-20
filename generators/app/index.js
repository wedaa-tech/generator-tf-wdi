const path = require("path");
const fs = require("fs");
const Generator = require("yeoman-generator");
// Const prompts = require("./assets/prompts");

const {
  fileListEks,
  fileListEksDrivers,
  fileListEck,
  fileListGcp,
  fileListAzure,
  fileListMinikube,
  fileListHelmIstio,
  fileListECR,
  fileListEcrBuildAndPush,
  fileListIstioMonitoring,
  fileListEksWebUI
} = require("./assets/filesList");

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    if (opts.file) {
      const filePath = path.resolve(opts.file);
      const fileContents = fs.readFileSync(filePath, "utf8");
      const options = JSON.parse(JSON.stringify(fileContents));
      this.options = options;
    }
  }

  // Prompting() {
  //   this.log("Welcome to TIC\n");
  //   this.log("WDI Infrastructure Generator\n");
  //   return this.prompt(prompts).then(props => {
  //     this.props = props;
  //   });
  // }

  writing() {
    const copyOpts = {
      globOptions: {
        ignore: []
      }
    };

    const options = JSON.parse(this.options);

    // Const options = {
    //   name:  this.props.name,
    //   domain: this.props.domain,
    //   cloudProvider: this.props.cloudProvider,
    //   orchestration: this.props.orchestration,
    //   awsRegion: this.props.awsRegion,
    //   awsAccessKey: this.props.awsAccessKey,
    //   awsSecretKey: this.props.awsSecretKey,
    //   // gcpProject: this.props.gcpProject,
    //   // gcpRegion: this.props.gcpRegion,
    //   // gcpZone: this.props.gcpZone,
    //   namespace: this.props.namespace,
    //   clusterName: this.props.clusterName,
    //   ingress: this.props.ingress,
    //   // react: this.props.react,
    //   // reactImage: this.props.reactImage,
    //   // reactPort: this.props.reactPort,
    //   // angular: this.props.angular,
    //   // vuejs: this.props.vuejs,
    //   // a12nServer: this.props.a12nServer,
    //   // keycloak: this.props.keycloak,
    //   // keycloakRealmName: this.props.keycloakRealmName,
    //   // keycloakPublicClient: this.props.keycloakPublicClient,
    //   // keycloakClientId: this.props.keycloakClientId, // Keycloakname
    //   // keycloakAdminUser: this.props.keycloakAdminUser,
    //   // keycloakAdminPassword: this.props.keycloakAdminPassword,
    //   // keycloakDefaultUser: this.props.keycloakDefaultUser,
    //   // keycloakDefaultUserPassword: this.props.keycloakDefaultUserPassword,
    //   // keycloakEmail: this.props.keycloakEmail,
    //   // keycloakFirstName: this.props.keycloakFirstName,
    //   // keycloakLastName: this.props.keycloakLastName,
    //   // keycloakDBPassword: this.props.keycloakDBPassword,
    //   // nodejs: this.props.nodejs,
    //   // nodejsPort: this.props.nodejsPort,
    //   // nodejsImage: this.props.nodejsImage,
    //   // spring: this.props.spring,
    //   // springPort: this.props.springPort,
    //   // springImage: this.props.springImage,
    //   // flask: this.props.flask,
    //   // flaskPort: this.props.flaskPort,
    //   // flaskImage: this.props.flaskImage,
    //   // golang: this.props.golang,
    //   // mysql: this.props.mysql,
    //   // postgreSql: this.props.postgreSql,
    //   // postgrePassword: this.props.postgrePassword,
    //   // postgreUserName: this.props.postgreUserName,
    //   // postgreServerName: this.props.postgreServerName,
    //   // postgreDatabaseName: this.props.postgreDatabaseName,
    //   // mongoDB: this.props.mongoDB,
    //   // redis: this.props.redis,
    //   // cassandra: this.props.cassandra,
    //   // neo4j: this.props.neo4j
    // };

    this.log(options);

    try {
      switch (options.cloudProvider) {
        case "aws":
          this.log("AWS Generator");
          this._fileHelper(fileListEks, options, copyOpts);
          this._fileHelper(fileListEksDrivers, options, copyOpts);
          break;
        case "gcp":
          this.log("GCP Generator");
          this._fileHelper(fileListGcp, options, copyOpts);
          break;
        case "azure":
          this.log("Azure Generator");
          this._fileHelper(fileListAzure, options, copyOpts);
          break;
        case "minikube":
          this.log("minikube Generator");
          this._fileHelper(fileListMinikube, options, copyOpts);
          break;
        default:
          console.log(`Sorry, we are out of ${options.cloudProvider}.`);
      }

      this.log("Adding Helm to cloud provider");
      this._fileHelper(fileListHelmIstio, options, copyOpts);

      // Can be used in future versions <create Namespace>
      // this._fileHelper(fileListNamespace, options, copyOpts);

      // Generate ECR repositories only if the generateInfra is true
      if (options.generateInfra === "true") {
        this._fileHelper(fileListECR, options, copyOpts);
        this._fileHelper(fileListEcrBuildAndPush, options, copyOpts);
      }

      // Generate Monitoring Files only if the monitoring is true
      if (options.monitoring === "true") {
        this._fileHelper(fileListIstioMonitoring, options, copyOpts);
      }

      // Generate K8s Web UI only if the k8sWebUI is true
      if (options.k8sWebUI === "true") {
        this._fileHelper(fileListEksWebUI, options, copyOpts);
      }

      if (options.enableECK === "true") {
        this._fileHelper(fileListEck, options, copyOpts);
      }

      // This._servicesOptionsHelper(options, copyOpts);
    } catch (error) {
      this.log(error);
    }
  }

  // _servicesOptionsHelper(options, copyOpts) {
  //   if (options.react) {
  //     this.log("React...");
  //     this._fileHelper(fileListReact, options, copyOpts);
  //   }

  //   if (options.angular) {
  //     this.log("Angular...");
  //     // This._fileHelper(fileListAngular, options, copyOpts);
  //   }

  //   if (options.vuejs) {
  //     this.log("Vue.js...");
  //     // This._fileHelper(fileListVuejs, options, copyOpts);
  //   }

  //   if (options.keycloak) {
  //     this.log("keycloak...");
  //     this._fileHelper(fileListKeycloak, options, copyOpts);
  //   }

  //   if (options.a12nServer) {
  //     this.log("a12nServer is not supported yet");
  //   }

  //   if (options.nodejs) {
  //     this.log("keycloak...");
  //     // This._fileHelper(fileListNodejs, options, copyOpts);
  //   }

  //   if (options.spring) {
  //     this.log("spring...");
  //     this._fileHelper(fileListSpring, options, copyOpts);
  //   }

  //   if (options.flask) {
  //     this.log("flask...");
  //     // This._fileHelper(fileListFlask, options, copyOpts);
  //   }

  //   if (options.golang) {
  //     this.log("golang...");
  //     // This._fileHelper(fileListGolang, options, copyOpts);
  //   }

  //   if (options.mysql) {
  //     this.log("mysql...");
  //     // This._fileHelper(fileListMysql, options, copyOpts);
  //   }

  //   if (options.postgreSql) {
  //     this.log("postgreSql...");
  //     this._fileHelper(fileListPostgreSql, options, copyOpts);
  //   }

  //   if (options.mongoDB) {
  //     this.log("mongoDB is not supported yet");
  //     // This._fileHelper(fileListMongoDB, options, copyOpts);
  //   }

  //   if (options.redis) {
  //     this.log("redis is not supported yet");
  //     // This._fileHelper(fileListRedis, options, copyOpts);
  //   }

  //   if (options.cassandra) {
  //     this.log("cassandra is not supported yet");
  //     // This._fileHelper(fileListCassandra, options, copyOpts);
  //   }

  //   if (options.neo4j) {
  //     this.log("neo4j is not supported yet");
  //     // This._fileHelper(fileListNeo4j, options, copyOpts);
  //   }
  // }

  _fileHelper(fileList, opts, copyOpts) {
    fileList.forEach(file => {
      this.fs.copyTpl(
        this.templatePath(file),
        this.destinationPath(`${opts.projectName}/terraform/${file}`),
        opts,
        copyOpts
      );
    });
  }

  install() {
    this.log("Terraform files Generation completed...");
  }
};
