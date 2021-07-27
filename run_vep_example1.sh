#!/bin/bash

# CROMWELL v64
CROMWELL="/path/to/cromwell.jar"
INPUT_JSON="./example_data/vep_input/vep_input.json"

java -jar $CROMWELL run vep/vep-task.wdl -i $INPUT_JSON
