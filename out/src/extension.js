"use strict";
/// <reference types="atom-typings" />
Object.defineProperty(exports, "__esModule", { value: true });
const atom_1 = require("atom");
let subscriptions = null;
function activate(state) {
    subscriptions = new atom_1.CompositeDisposable();
    // Set opener
    subscriptions.add(atom.workspace.addOpener((uri) => {
        if (uri.startsWith('mpe://')) {
        }
    }));
}
exports.activate = activate;
function deactivate() {
    subscriptions.dispose();
}
exports.deactivate = deactivate;
var config_schema_1 = require("./config-schema");
exports.config = config_schema_1.configSchema;
