const session = require('express-session');
const Keycloak = require('keycloak-connect');

const memoryStore = new session.MemoryStore();

const keycloakConfig = require('../configs/keycloak-config.json'); // Assurez-vous que le chemin est correct
const keycloak = new Keycloak({ store: memoryStore }, keycloakConfig);

const keycloakMiddleware = (app) => {
    app.use(session({
        secret: 'thisShouldBeLongAndSecret',
        resave: false,
        saveUninitialized: true,
        store: memoryStore
    }));
    app.use(keycloak.middleware());
};

module.exports = {
    keycloak,
    keycloakMiddleware
};
