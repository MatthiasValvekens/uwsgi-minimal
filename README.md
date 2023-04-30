# uwsgi-minimal


A minimal image for running Python apps with uWSGI.


# Sample invocation

The repository includes [this classic Hello World example](https://www.shellhacks.com/modwsgi-hello-world-example/) for demonstration purposes.

```bash
docker run \
    --mount type=bind,src=$(pwd)/example/hello-world-wsgi.py,dst=/srv/wsgi.py \
    -p 9001:9001 --rm -it \
    mfjval/uwsgi-minimal:latest-py3.10
```

Then run

```bash
curl localhost:9001
```

You should see "Hello World!" appear in the output.
