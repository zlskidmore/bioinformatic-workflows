#!/usr/bin/env cwl-runner

class: CommandLineTool

cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: zlskidmore/picard:2.20.2
  - class: ResourceRequirement
    ramMin: 24000
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference)

baseCommand: [ "java", "-Xmx22g", "-jar", "/usr/bin/picard/picard.jar", "CreateSequenceDictionary"]

arguments:
  - valueFrom: $(inputs.reference.nameroot).dict
    position: 1
    prefix: "OUTPUT="

inputs:
  reference:
    type: File
    inputBinding:
      position: 2
      valueFrom: "$(runtime.outdir)/$(inputs.reference.basename)"
      prefix: "REFERENCE="

outputs:
  referenceDict:
    type: File
    secondaryFiles: [^.dict]
    outputBinding:
      glob: $(inputs.reference.basename)
