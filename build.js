var Handlebars = require('handlebars');
var fs = require('fs');
var config = require('./config.json');
var exec = require('child_process').execSync;

var buildDir = 'build';
var srcDir = 'src';


forEachFile(fileName => {
    var file = fs.readFileSync(fileName);
    var template = Handlebars.compile(file.toString());
    var compiledFile = template(config);
    var compiledFileName = fileName.replace(srcDir + '/', buildDir + '/');

    fs.writeFileSync(compiledFileName, compiledFile);
});


function forEachFile(callback) {
    var fileNames = findFiles(srcDir);
    var dirNames = findDirectories(srcDir);

    dirNames = dirNames.map(dirName => {
        return dirName.replace(srcDir, buildDir);
    });

    makeDirectories(dirNames);
    
    fileNames.forEach(fileName => {
        console.log(fileName);
        callback(fileName);
    });
}

function findFiles(directory) {
    return find(directory, 'f');
}

function findDirectories(directory) {
    return find(directory, 'd');
}

function find(directory, type) {
    var command = 'find ' + directory + ' -type ' + type;
    var output = exec(command);
    var strOutput = output.toString();
    var arrayOutput = strOutput.split('\n');

    arrayOutput = arrayOutput.filter(name => {
        return name !== '';
    });

    return arrayOutput;
}

function makeDirectories(directories) {
    directories.forEach(dirName => {
        exec('mkdir -p ' + dirName);
    });
}
