ARG BASE_IMAGE=busybox

ARG CACHE_IMAGE=$BASE_IMAGE

FROM $CACHE_IMAGE as cache
FROM $BASE_IMAGE as base

# file copied
COPY --from=cache /bin/yes /tmp/
COPY --from=cache /bin/yes /tmp/no
COPY --from=cache /bin/yes /tmp/non-exist
COPY --from=cache /bin/yes /tmp/non-exist-dir/
# content copied
COPY --from=cache /usr/bin /tmp/
COPY --from=cache /usr/bin/ /tmp/2

COPY --from=cache /usr/bin/ /tmp/3/bin/

CMD ls /tmp
