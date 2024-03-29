# Overview

This directory contains the description of the various architecture
diagrams prepared for interTwin deliverable D5.1, following the [C4
paradigm](https://c4model.com/).

The digrams were prepared using an open-source editor
[Structurizr](https://structurizr.com/).  In particular, the
stand-alone "lite" version was deployed locally.

## How to run Structurizr

The following command provides a template for how to run the container
image, assuming this file is located in the directory:
`~/git/interTwin/architecture-diagrams/WP5/T5.2`.  The specific
example uses `podman` to run the container image; however, simply
replacing `podman` with `docker` should yield the command to work with
Docker.

```shell
podman run -it --rm -p 8080:8080 -v ~/git/interTwin/architecture-diagrams/WP5/T5.2:/usr/local/structurizr structurizr/lite
```

Once this command has started, the editor is available by pointing
your web-browser at
[http://localhost:8080/](http://localhost:8080/).

## Files and directories

The file `workspace.dsl` contains the description of the elements of
the diagram, following the [Structurizr
DSL](https://github.com/structurizr/dsl).  This is the main point for
making structural changes to the diagram, typically by some external
text editor.

The file `workspace.json` is autogenerated by Structurizr and holds
the precise location of elements on the diagram.

The directory `images/` contains the various icons and logos that are
embedded within various elements.  Unfortunately, these images cannot
use a vector graphics (SVG), so they are in PNG format.

The directory 'output/' contains the C4 diagrams, as generated by
Structurizr.  This is intended to allow people to obtain the output
quickly, without requiring people to run Structurizr.
