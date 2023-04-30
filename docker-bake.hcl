variable "TARGET_PYTHON_VERSION" {
    default = "3.10"
}

function "formattag" {
    params = [repo, prefix]
    result = "${repo}:${prefix}-py${TARGET_PYTHON_VERSION}"
}

group "default" {
    targets = ["dev"]
}

target "dev" {
    context = "src"
    tags = [formattag("mfjval/uwsgi-minimal", "latest")]
    args = {
        TARGET_PYTHON_VERSION = TARGET_PYTHON_VERSION
    }
}

target "release" {
    inherits = ["dev"]
    platforms = ["linux/amd64", "linux/arm64"]
    tags = [
        formattag("docker.io/mfjval/uwsgi-minimal", "latest"),
    ]
}
