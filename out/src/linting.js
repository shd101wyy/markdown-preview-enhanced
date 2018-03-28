"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
let linter;
function consumeIndie(registerIndie) {
    linter = registerIndie({
        name: "Litvis",
    });
}
exports.consumeIndie = consumeIndie;
exports.updateLintingReport = (vFiles = []) => {
    // Setting and replacing all messages
    linter.setAllMessages(vFiles
        .reduce((arr, vFile) => arr.concat(vFile.messages), [])
        .map(transform));
};
// helper functions inspired by
// https://github.com/unifiedjs/unified-engine-atom/blob/126acb8c4491be442752433be02791cb7a61a60e/index.js#L79-L128
/* Transform VFile messages nested-tuple. */
function transform(message) {
    const labels = [message.source, message.ruleId].filter(Boolean);
    let excerpt = message.stack || undefined;
    if (labels[0] && labels[0] === labels[1]) {
        labels.pop();
    }
    const label = labels.join(":");
    if (!excerpt) {
        excerpt = message.reason.replace(/“([^”]+)”/g, "`$1`");
    }
    if (label) {
        excerpt += " (" + label + ")";
    }
    return {
        severity: {
            true: "error",
            false: "warning",
            null: "info",
            undefined: "info",
        }[message.fatal],
        location: {
            file: message.file,
            position: toRange(message.location),
        },
        excerpt,
        description: message.note,
    };
}
/* Transform a (stringified) vfile range to a linter nested-tuple. */
function toRange(location) {
    const result = [
        [Number(location.start.line) - 1, Number(location.start.column) - 1],
    ];
    result[1] = [
        location.end.line ? Number(location.end.line) - 1 : result[0][0],
        location.end.column ? Number(location.end.column) - 1 : result[0][1],
    ];
    return result;
}
//# sourceMappingURL=linting.js.map