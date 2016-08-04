# Entry

OpenFace house guest recognition

## Setup

### Linux

Execute `setup.sh`

## Usage

* First and only once execute `openface/models/get-models.sh`

* Create subfolders in `images/training` e.g. `images/training/neo` and `images/training/terminator`
* Copy the images of the person into the corresponding subfolders
* Execute `align.sh`
* Execute `embed.sh`
* Execute `train.sh`
* Execute `classifier.sh PATH_TO_IMAGE` to identify the person
